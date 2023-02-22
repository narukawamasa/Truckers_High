# frozen_string_literal: true

class Public::TransportCompany::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  before_action :transport_company_state, only: [:create]

  def after_sign_in_path_for(resource)
    transport_company_path(current_transport_company)
  end

  protected


  def transport_company_state
    @transport_company = TransportCompany.find_by(email: params[:transport_company][:email])
    return if !@transport_company

    if @transport_company.valid_password?(params[:transport_company][:password]) && !@transport_company.is_deleted
    else
      redirect_to "/transport_companies/sign_up"
    end

  end


end
