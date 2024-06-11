class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable

  # Add callbacks for password reset
  before_password_reset :invalidate_sessions_before_password_reset
  after_password_reset :invalidate_sessions_after_password_reset

  private

  def invalidate_sessions_before_password_reset
    # Invalidate sessions before password reset
    invalidate_all_sessions
  end

  def invalidate_sessions_after_password_reset
    # Invalidate sessions after password reset
    invalidate_all_sessions
  end

  def invalidate_all_sessions
    # Code to invalidate all user sessions
    self.update_column(:invalidate_sessions_at, Time.current)
  end
end
