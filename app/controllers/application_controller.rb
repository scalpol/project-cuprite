class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user

  def current_user
    current_player
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :profile_picture, :country_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_picture])
  end
end
