class User < ApplicationRecord
  # Assuming Devise is used for authentication
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_secure_password
  
  # Custom method to invalidate sessions
  def invalidate_sessions_before_password_reset
    # Your logic to invalidate sessions
  end

  # Override Devise's method to include custom action
  def reset_password(new_password, new_password_confirmation)
    invalidate_sessions_before_password_reset
    super
  end
end