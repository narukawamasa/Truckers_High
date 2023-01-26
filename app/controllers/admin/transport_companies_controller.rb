class Admin::TransportCompaniesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @transport_companies = TransportCompany.page(params[:page])
    @number = 1
  end

  def show
    @transport_company = TransportCompany.find(params[:id])
  end

end
