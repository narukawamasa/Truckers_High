class Public::DriversController < ApplicationController

  def show
    @driver = Driver.find(params[:id])
  end

  def index
    @drivers = Driver.where(transport_company_id: current_transport_company.id)
    @number = 1
  end

  def update
    @driver = Driver.find(current_driver.id)
    if @driver.transport_company_id == nil
      @driver.update(driver_params)
    else
      @driver.update(transport_company_id: nil)
    end
    redirect_to request.referer
  end

  private

  def driver_params
    params.require(:driver).permit(:transport_company_id)
  end


end
