class Public::RoomsController < ApplicationController
  before_action :authenticate_any!


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

end
