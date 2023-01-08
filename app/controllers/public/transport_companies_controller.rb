class Public::TransportCompaniesController < ApplicationController
  
  def show
    @transport_company = TransportCompany.find(params[:id])
  end
  
  def index
    @transport_companies = TransportCompany.all
    @number = 1
  end
  
end
