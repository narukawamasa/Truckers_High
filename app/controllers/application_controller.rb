class ApplicationController < ActionController::Base
  before_action :authenticate_driver!, except: [:top]

end
