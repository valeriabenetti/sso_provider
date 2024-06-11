Doorkeeper.configure do
  resource_owner_from_credentials do |_routes|
    user = User.find_for_database_authentication(email: params[:email])
    user if user&.valid_password?(params[:password])
  end

  access_token_expires_in 2.hours
  use_refresh_token
  enforce_configured_scopes

  grant_flows %w[password]

  skip_authorization do |_resource_owner, _client|
    true
  end
end
