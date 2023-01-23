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
    @bookmark = Bookmark.new
    if params[:word] == nil || params[:word] == ""
      @companies = Company.all
    else
      word = params[:word]
      search = params[:search]
      range = params[:range]
      if search == "partial_match"
        if range == "name"
          @companies = Company.where("name LIKE?","%#{word}%")
          @word = word
        elsif range == "adress"
          @companies = Company.where("address LIKE?","%#{word}%")
          @word = word
        end
      else
        @companies = Company.all
      end

      unless @companies.exists?
        @companies = Company.all
        @word_error = word
      end

    end
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
