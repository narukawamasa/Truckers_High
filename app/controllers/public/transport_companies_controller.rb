class Public::TransportCompaniesController < ApplicationController

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

end
