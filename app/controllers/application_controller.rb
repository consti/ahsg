class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :update_sanitized_params, if: :devise_controller?

  protected

  def update_sanitized_params
    permitted = [
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :profession,
      :title,
      :date_of_birth,
      :graduated,
      :was_in_boarding_school,
      :nick_name,
      :school_year_begin,
      :school_year_end,
      :current_password,
      location_attributes: [:address, :id]
    ]

    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(permitted) }
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(permitted) }
  end
end
