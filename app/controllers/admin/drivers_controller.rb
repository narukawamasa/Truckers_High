class Admin::DriversController < ApplicationController
  before_action :authenticate_admin!

  def show
    @driver = Driver.find(params[:id])
  end

  def index
    @drivers = Driver.page(params[:page])
    @number = 1
  end

end
