class Admin::TransportCompaniesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @transport_companies = TransportCompany.page(params[:page])
    @number = 1
  end

  def show
    @transport_company = TransportCompany.find(params[:id])
  end

  def update
    transport_company = TransportCompany.find(params[:id])
    transport_company.update(transport_company_params)

    drivers = Driver.where(transport_company_id: transport_company.id)
    drivers.each do |driver|
      driver.update(transport_company_id: nil)
    end

    redirect_to request.referer
  end


  private

  def transport_company_params
    params.require(:transport_company).permit(:name, :is_deleted, :postal_code, :address, :introduction, :phone_number, :email, :profile_image)
  end

end
