Doorkeeper.configure do
  # Define application owner email
  resource_owner_from_credentials do |_routes|
    user = User.find_by(email: params[:email])
    user if user&.valid_password?(params[:password])
  end

  # Access token expiration time
  access_token_expires_in 2.hours

  # Enable refresh token
  use_refresh_token

  # Require SSL in redirect URI
  enforce_ssl_in_redirect_uri false
end
