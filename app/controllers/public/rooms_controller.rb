class Public::RoomsController < ApplicationController
  before_action :authenticate_any!
  before_action :is_matching_login, only: [:show]


  def create
    #driver contorollerに記述
  end

  def show
    @message = Message.new
    @room = Room.find(params[:id])
    @messages = Message.where(room_id: @room.id)
    if driver_signed_in?
      @message_transport_company = @messages.where(messageable_type: "TransportCompany")
      @message_transport_company.each do |message|
        if message.notification.confirmation_status == false
          message.notification.update(confirmation_status: true)
        end
      end
    elsif transport_company_signed_in?
      @message_driver = @messages.where(messageable_type: "Driver")
      @message_driver.each do |message|
        if message.notification.confirmation_status == false
          message.notification.update(confirmation_status: true)
        end
      end
    end
  end

  def index
    @rooms = Room.where(transport_company_id: current_transport_company.id)
  end

  private

  def room_params
    params.require(:room).permit(:transport_company_id, :driver_id)
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

  def is_matching_login
    if driver_signed_in?
      room_id = params[:id].to_i
      unless current_driver.rooms.find_by(id: room_id)
        redirect_to driver_path(current_driver)
      end
    elsif transport_company_signed_in?
      room_id = params[:id].to_i
      unless current_transport_company.rooms.find_by(id: room_id)
        redirect_to transport_company_path(current_transport_company)
      end
    end
  end


end
