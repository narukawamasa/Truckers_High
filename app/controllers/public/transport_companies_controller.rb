class Public::TransportCompaniesController < ApplicationController

  def show
    @transport_company = TransportCompany.find(params[:id])
    if driver_signed_in?
      @driver = Driver.find(current_driver.id)
    end
  end

  def index
    @transport_companies = TransportCompany.all
    @number = 1
  end

  def edit
    @transport_company = TransportCompany.find(params[:id])
  end

  def update
    @transport_company = TransportCompany.find(params[:id])
    @transport_company.update(transport_company_params)
    redirect_to transport_company_path(@transport_company.id)
  end

  private

  def transport_company_params
    params.require(:transport_company).permit(:name, :postal_code, :address, :introduction, :phone_number, :email, :profile_image)
  end

end
