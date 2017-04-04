class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:First_name, :Last_name, :birthday, :language_id, :terms_conditions])
    devise_parameter_sanitizer.permit(:account_update, keys: [:First_name, :Last_name, :birthday, :language_id])
  end

end
