class Public::PossessionLicensesController < ApplicationController

  def create
    possession_license = PossessionLicense.new(possession_license_params)
    possession_license.save
    @licenses = License.all
    @possession_license = PossessionLicense.new
  end

  def destroy
    possession_license = PossessionLicense.find_by(license_id: params[:id], driver_id: current_driver.id)
    possession_license.destroy
    @licenses = License.all
    @possession_license = PossessionLicense.new
  end

  private
  def possession_license_params
      params.require(:possession_license).permit(:driver_id, :license_id)
  end

end
