Doorkeeper.configure do
  # Set the ORM to be used (ActiveRecord or Sequel)
  orm :active_record

  # Define the available authorization flows (e.g., password, authorization_code, client_credentials, etc.)
  grant_flows %w[authorization_code client_credentials]

  # Define access token expiration time (default is 2 hours)
  access_token_expires_in 2.hours

  # Define the client credentials (OAuth applications)
  resource_owner_authenticator do
    User.find_by_id(session[:user_id]) || redirect_to(new_user_session_url)
  end

  # Define how to authenticate client applications
  client_credentials do
    client = OAuthApplication.find_by(uid: params[:client_id])
    client && client.secret == params[:client_secret]
  end

  # Define allowed redirect URIs for client applications
  skip_authorization do
    true
  end
end
