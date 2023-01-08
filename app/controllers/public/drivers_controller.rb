class Public::DriversController < ApplicationController
  
  def show
    @driver = Driver.find(params[:id])
  end
  
  def index
    @drivers = Driver.where(transport_company_id: current_transport_company.id)
    @number = 1
  end
  
end
