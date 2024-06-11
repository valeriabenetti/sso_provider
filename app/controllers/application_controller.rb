class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :check_session_validity

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def check_session_validity
    if current_user && current_user.invalidate_sessions_at.present? && current_user.invalidate_sessions_at > current_user.updated_at
      sign_out current_user
      redirect_to root_path, alert: 'Your session has expired. Please log in again.'
    end
  end
end
