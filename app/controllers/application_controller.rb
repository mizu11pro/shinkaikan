class ApplicationController < ActionController::Base
  before_action :configure_permitted_paremeters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    homes_path
  end

  def after_sign_in_path_for(resource)
    movies_path
  end

  def after_sign_out_path_for(resource)
    user_session_path
  end

  protected

  def configure_permitted_paremeters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
