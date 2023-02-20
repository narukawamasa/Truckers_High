class Public::DriversController < ApplicationController
  before_action :authenticate_any!
  before_action :is_matching_login_driver, only: [:show, :edit, :update, :update_all]

  def show
    @driver = Driver.find(params[:id])
  end

  def index
    @drivers = Driver.where(transport_company_id: current_transport_company.id).page(params[:page])
    @number = 1
  end

  def edit
    @driver = Driver.find(params[:id])
    possession_licenses = current_driver.possession_licenses.all
    if possession_licenses.exists?
      possession_license_id = possession_licenses.pluck(:license_id)
      @licenses = License.where.not(id: possession_license_id)
    else
      @licenses = License.all
    end

  end

  def update
    @driver = Driver.find(current_driver.id)
    #下記運送会社に所属してない場合に、初めて所属した運送会社とのルームも同時に作成する
    if @driver.transport_company_id == nil
      @driver.update(driver_params)
      if @driver.rooms.exists?(transport_company_id: @driver.transport_company_id)
        redirect_to request.referer
      else
        @room = Room.new
        @room = Room.create!({driver_id: current_driver.id, transport_company_id: @driver.transport_company_id})
        #redirect_to controller: :rooms, action: :create
        redirect_to room_path(@room.id)
      end
    else
      @driver.update(transport_company_id: nil)
      redirect_to request.referer
    end
  end

  def update_all
    @driver = Driver.find(params[:id])
    if @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
    else
      possession_licenses = current_driver.possession_licenses.all
      if possession_licenses.exists?
        possession_license_id = possession_licenses.pluck(:license_id)
        @licenses = License.where.not(id: possession_license_id)
      else
        @licenses = License.all
      end
      render :edit
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:transport_company_id, :family_name, :first_name, :family_name_kana, :first_name_kana, :introduction, :phone_number, :email, :profile_image, possession_licenses_attributes: [:license_id, :_destroy])
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

  def is_matching_login_driver
    if driver_signed_in?
      driver_id = params[:id].to_i
      unless driver_id == current_driver.id
        redirect_to driver_path(current_driver)
      end
    elsif transport_company_signed_in?
      driver_id = params[:id].to_i
      unless current_transport_company.drivers.find_by(id: driver_id)
        redirect_to transport_company_path(current_transport_company)
      end
    end
  end


end
