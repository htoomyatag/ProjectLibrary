class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token
  helper_method :is_system_admin?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :is_leave, :is_admin])
  end

  def is_system_admin?
    if user_signed_in?
      current_user.is_admin == true 
    end
  end



end

