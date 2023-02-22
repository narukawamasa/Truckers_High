class Admin::DriversController < ApplicationController
  before_action :authenticate_admin!

  def show
    @driver = Driver.find(params[:id])
  end

  def index
    @drivers = Driver.page(params[:page])
    @number = 1
  end

  def update
    driver = Driver.find(params[:id])
    driver.update(driver_params)
    redirect_to request.referer
  end

  private

  def driver_params
    params.require(:driver).permit(:transport_company_id, :is_deleted, :family_name, :first_name, :family_name_kana, :first_name_kana, :introduction, :phone_number, :email)
  end

end
