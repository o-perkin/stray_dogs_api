module DeviseWhitelist
  extend ActiveSupport::Concern

  included do 
    before_action :configure_permited_parameters, if: :devise_controller?
  end

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end