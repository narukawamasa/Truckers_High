class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!


  def index
    @companies = Company.page(params[:page])
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    redirect_to admin_company_path(@company.id)
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to admin_companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :postal_code, :address, :phone_number, :profile_image)
  end

end
