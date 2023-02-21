class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @number = 0
    @contacts = Contact.where.not(status: 2).page(params[:page])
  end

  def index_ok
    @number = 0
    @contacts = Contact.where(status: 2).page(params[:page])
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(contact_params)
    redirect_to admin_contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:contactable_id, :contactable_type, :contact_company_id, :category, :text, :status)
  end

end
