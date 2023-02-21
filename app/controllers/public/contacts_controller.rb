class Public::ContactsController < ApplicationController


  def new
    unless driver_signed_in? || transport_company_signed_in?
      redirect_to root_path
    end

    @contact = Contact.new
    if params[:contact].present?
      @company = Company.find(params[:contact][:contact_company_id])
    else
      @company = nil
    end
  end

  def create
    unless driver_signed_in? || transport_company_signed_in?
      redirect_to root_path
    end

    @contact = Contact.new(contact_params)
    if @contact.contact_company_id.present?
      @company = Company.find_by(id: @contact.contact_company_id)
    end
    if @contact.save
      if driver_signed_in?
        redirect_to driver_path(current_driver.id)
      elsif transport_company_signed_in?
        redirect_to transport_company_path(current_transport_company.id)
      end
    else
      render :new
    end
  end

  def show
    if driver_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "driver", contactable_id: current_driver.id)
      unless @contact.present?
        redirect_to driver_path(current_driver.id)
      end
    elsif transport_company_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "transport_company", contactable_id: current_transport_company.id)
      unless @contact.present?
        redirect_to transport_company_path(current_transport_company.id)
      end
    else
      redirect_to root_path
    end
  end

  def edit
    if driver_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "driver", contactable_id: current_driver.id)
      unless @contact.present?
        redirect_to driver_path(current_driver.id)
      end
    elsif transport_company_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "transport_company", contactable_id: current_transport_company.id)
      unless @contact.present?
        redirect_to transport_company_path(current_transport_company.id)
      end
    else
      redirect_to root_path
    end
  end

  def update
    if driver_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "driver", contactable_id: current_driver.id)
      unless @contact.present?
        redirect_to driver_path(current_driver.id)
      end
      if @contact.update(contact_params)
        redirect_to contacts_path
      else
        render :edit
      end
    elsif transport_company_signed_in?
      @contact = Contact.find_by(id: params[:id], contactable_type: "transport_company", contactable_id: current_transport_company.id)
      unless @contact.present?
        redirect_to transport_company_path(current_transport_company.id)
      end
      if @contact.update(contact_params)
        redirect_to contacts_path
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def index
    if driver_signed_in?
      @contacts = Contact.where(contactable_type: "driver", contactable_id: current_driver.id).page(params[:page])
    elsif transport_company_signed_in?
      @contacts = Contact.where(contactable_type: "transport_company", contactable_id: current_transport_company.id).page(params[:page])
    else
      redirect_to root_path
    end
    @number = 0
  end

  private

  def contact_params
    params.require(:contact).permit(:contactable_id, :contactable_type, :contact_company_id, :category, :text, :status)
  end

end
