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
      @transport_companies = TransportCompany.all
    else
      word = params[:word]
      search = params[:search]
      if search == "perfect_match"
        @transport_companies = TransportCompany.where("name LIKE?", "#{word}")
        @word = word
      elsif search == "forward_match"
        @transport_companies = TransportCompany.where("name LIKE?","#{word}%")
        @word = word
      elsif search == "backward_match"
        @transport_companies = TransportCompany.where("name LIKE?","%#{word}")
        @word = word
      elsif search == "partial_match"
        @transport_companies = TransportCompany.where("name LIKE?","%#{word}%")
        @word = word
      else
        @transport_companies = TransportCompany.all
      end

      unless @transport_companies.exists?
        @transport_companies = TransportCompany.all
        @word_error = word
      end

    end
  end

  def edit
    @transport_company = TransportCompany.find(params[:id])
  end

  def update
    @transport_company = TransportCompany.find(params[:id])
    @transport_company.update(transport_company_params)
    redirect_to transport_company_path(@transport_company.id)
  end

  private

  def transport_company_params
    params.require(:transport_company).permit(:name, :postal_code, :address, :introduction, :phone_number, :email, :profile_image)
  end

end
