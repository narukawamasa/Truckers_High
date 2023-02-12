class Admin::HomesController < ApplicationController
  #before_action :authenticate_admin!

  def top
    if driver_signed_in?
      redirect_to driver_path(current_driver)
    elsif transport_company_signed_in?
      redirect_to transport_company_path(current_transport_company)
    elsif admin_signed_in?
    else
      redirect_to new_admin_session_path
    end
  end

end
