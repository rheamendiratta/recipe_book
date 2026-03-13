class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:display_name])
  end

  def require_ownership(record, user_field: :user_id)
    unless record.send(user_field) == current_user.id
      redirect_to root_path, alert: "You don't have permission to do that."
    end
  end
end
