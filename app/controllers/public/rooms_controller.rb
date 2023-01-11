class Public::RoomsController < ApplicationController

  def create
    @room = current_driver.rooms.new(room_params)
    @room.transport_company_id = current_driver.transport_companies.id
    @room.save
    redirect_to driver_path(current_driver)
  end

  def show
  end

  def index
  end

  def room_params
    params.require(:room).permit(:transport_company_id, :driver_id)
  end

end
