class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:First_name, :Last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:First_name, :Last_name])
  end

end
