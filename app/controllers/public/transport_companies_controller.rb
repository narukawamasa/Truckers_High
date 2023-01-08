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

end
