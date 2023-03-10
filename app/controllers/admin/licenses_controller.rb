class Admin::LicensesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @licenses = License.page(params[:page])
    @license = License.new
  end

  def create
    @licenses = License.all
    @license = License.new(license_params)
    @license.save
    #redirect_to request.referer
  end

  def edit
    @license = License.find(params[:id])
  end

  def update
    @license = License.find(params[:id])
    @license.update(license_params)
    redirect_to admin_licenses_path
  end

  def destroy
    @license = License.find(params[:id])
    @license.destroy
    redirect_to request.referer
  end

  private

  def license_params
    params.require(:license).permit(:name)
  end


end
