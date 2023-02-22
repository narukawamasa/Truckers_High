class Public::CompaniesController < ApplicationController
  before_action :authenticate_any!


  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if  @company.save
      redirect_to companies_path
    else
      render :new
    end
  end

  def index
    @bookmark = Bookmark.new
    if params[:word] == nil || params[:word] == ""
      #空白だった場合にすべての会社を表示
      @companies = Company.page(params[:page])
    else
      word = params[:word]
      #検索ワード
      search = params[:search]
      #部分一致のみ
      range = params[:range]
      #会社名か住所を選択
      if search == "partial_match"
        if range == "name"
          @companies = Company.where("name LIKE?","%#{word}%").page(params[:page])
          @word = word
        elsif range == "adress"
          @companies = Company.where("address LIKE?","%#{word}%").page(params[:page])
          @word = word
        end
      else
        @companies = Company.page(params[:page])
      end

      unless @companies.exists?
        @companies = Company.page(params[:page])
        @word_error = word
      end

    end
  end

  def show
    @company = Company.find_by(id: params[:id])
    if @company.nil?
      redirect_to root_path
    end
    @bookmark = Bookmark.new
  end



  private

  def company_params
    params.require(:company).permit(:name, :postal_code, :address, :phone_number, :profile_image)
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

end
