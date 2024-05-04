class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    flash[:alert] = "New registrations are not allowed."
    redirect_to root_path
  end

  def create
    flash[:alert] = "New registrations are not allowed."
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:timezone])
  end
end
