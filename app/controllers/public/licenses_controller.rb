class Public::LicensesController < ApplicationController

  def index
    @licenses = License.all
    @license = License.new
    @possession_license = PossessionLicense.new
    
  end

  def create
    @license = License.new(license_params)
    @license.save
    redirect_to request.referer
  end

  private

  def license_params
    params.require(:license).permit(:name)
  end


end
