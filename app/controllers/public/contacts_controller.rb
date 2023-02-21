class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
    if params[:contact].present?
      @company = Company.find(params[:contact][:contact_company_id])
    else
      @company = nil
    end
  end

  def create
    contact = Contact.new(contact_params)
    contact.save
    if driver_signed_in?
      redirect_to driver_path(current_driver.id)
    elsif transport_company_signed_in?
      redirect_to transport_company_path(current_transport_company.id)
    end
  end

  def edit
  end

  def updated
  end

  def index
  end

  private

  def contact_params
    params.require(:contact).permit(:contactable_id, :contactable_type, :contact_company_id, :category, :text, :status)
  end

end
