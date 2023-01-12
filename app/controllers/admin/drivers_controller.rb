class Admin::DriversController < ApplicationController
  
  def show
    @driver = Driver.find(params[:id])
  end
  
  def index
    @drivers = Driver.all
    @number = 1
  end
  
end
