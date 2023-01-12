class Admin::TransportCompaniesController < ApplicationController
  
  def index
    @transport_companies = TransportCompany.all
    @number = 1
  end
  
  def show
    @transport_company = TransportCompany.find(params[:id])
  end
  
end
