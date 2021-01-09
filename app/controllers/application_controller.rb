class ApplicationController < ActionController::Base
  before_action :configure_permitted_paremeters, if: :devise_controller?

  protected

  def configure_permitted_paremeters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
