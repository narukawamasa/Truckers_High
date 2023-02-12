class Public::HomesController < ApplicationController

  def top
    if driver_signed_in?
      redirect_to driver_path(current_driver)
    elsif transport_company_signed_in?
      redirect_to transport_company_path(current_transport_company)
    elsif admin_signed_in?
      redirect_to admin_root_path
    end
  end

end
