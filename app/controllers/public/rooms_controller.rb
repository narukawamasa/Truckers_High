class Public::RoomsController < ApplicationController

  def create
    #driver contorollerに記述
  end

  def show
    @message = Message.new
    @room = Room.find(params[:id])
    @messages = Message.where(room_id: @room.id)
  end

  def index
    @rooms = Room.where(transport_company_id: current_transport_company.id)
  end

  def room_params
    params.require(:room).permit(:transport_company_id, :driver_id)
  end

end
