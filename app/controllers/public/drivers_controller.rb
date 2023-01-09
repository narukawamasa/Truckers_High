class Public::DriversController < ApplicationController

  def show
    @driver = Driver.find(params[:id])
  end

  def index
    @drivers = Driver.where(transport_company_id: current_transport_company.id)
    @number = 1
  end

  def edit
    @driver = Driver.find(params[:id])
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

  def update_all
    @driver = Driver.find(params[:id])
    @driver.update(driver_params)
    redirect_to driver_path(@driver.id)
  end

  private

  def driver_params
    params.require(:driver).permit(:transport_company_id, :family_name, :first_name, :family_name_kana, :first_name_kana, :introduction, :phone_number, :email, :profile_image)
  end


end
