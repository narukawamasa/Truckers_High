class Public::LicensesController < ApplicationController

  def index
    @licenses = License.page(params[:page])
    @license = License.new
    @possession_license = PossessionLicense.new

  end

  def create
    @license = License.new(license_params)
    if @license.save
      redirect_to request.referer
    else
      @licenses = License.page(params[:page])
      @possession_license = PossessionLicense.new
      render :index
    end
  end

  private

  def license_params
    params.require(:license).permit(:name)
  end


end
