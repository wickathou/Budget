class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name,:email,:password,:password_confirmation)}

    devise_parameter_sanitizer.permit(:edit) { |u| u.permit(:name,:email,:password,:password_confirmation)}
  end
end
