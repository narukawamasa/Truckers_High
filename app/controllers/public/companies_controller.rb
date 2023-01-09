class Public::CompaniesController < ApplicationController

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.save
    redirect_to companies_path
  end

  def index
    @companies = Company.all
    @bookmark = Bookmark.new
    #@bookmarks = Bookmark.find_by(driver_id: current_driver.id, company_id: @companies.id)
  end

  def show
    @company = Company.find(params[:id])
    @bookmark = Bookmark.new
  end

  def edit
  end

  def update
  end


  private

  def company_params
    params.require(:company).permit(:name, :postal_code, :address, :phone_number, :profile_image)
  end

end
