class Public::TransportCompaniesController < ApplicationController
  before_action :authenticate_any!
  before_action :is_matching_login, only: [:edit, :update]

  def show
    @transport_company = TransportCompany.find(params[:id])
    if driver_signed_in?
      @driver = Driver.find(current_driver.id)
    end
  end

  def index
    @number = 1
    if params[:word] == nil || params[:word] == ""
      @transport_companies = TransportCompany.page(params[:page])
    else
      word = params[:word]
      search = params[:search]
      range = params[:range]
      if search == "partial_match"
        if range == "name"
          @transport_companies = TransportCompany.where("name LIKE?","%#{word}%").page(params[:page])
          @word = word
        elsif range == "adress"
          @transport_companies = TransportCompany.where("address LIKE?","%#{word}%").page(params[:page])
          @word = word
        end
      else
        @transport_companies = TransportCompany.page(params[:page])
      end

      unless @transport_companies.exists?
        @transport_companies = TransportCompany.page(params[:page])
        @word_error = word
      end

    end
  end

  def edit
    @transport_company = TransportCompany.find(params[:id])
  end

  def update
    @transport_company = TransportCompany.find(params[:id])
    if @transport_company.update(transport_company_params)
      redirect_to transport_company_path(@transport_company.id)
    else
      render :edit
    end
  end

  private

  def transport_company_params
    params.require(:transport_company).permit(:name, :postal_code, :address, :introduction, :phone_number, :email, :profile_image)
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

  def is_matching_login
    if driver_signed_in?
      redirect_to driver_path(current_driver)
    elsif transport_company_signed_in?
      transport_company_id = params[:id].to_i
      unless transport_company_id == current_transport_company.id
        redirect_to transport_company_path(current_transport_company)
      end
    end
  end

end
