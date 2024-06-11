class ApplicationController < ActionController::Base
  before_action :check_session_validity

  private

  def check_session_validity
    if current_user && current_user.invalidate_sessions_at.present? && current_user.invalidate_sessions_at > current_user.updated_at
      sign_out current_user
      redirect_to root_path, alert: 'Your session has expired. Please log in again.'
    end
  end
end
