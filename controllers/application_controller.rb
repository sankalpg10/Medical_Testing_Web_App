class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.admin?
      rails_admin_path # redirect to admin dashboard
    else
    dashboard_index_url # redirect to generic dashboard
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    user_params.permit(:username, :email, :role)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :role)
    end
  end
end
