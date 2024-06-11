class AuthenticationController < ApplicationController
  before_action :authenticate_user!, only: [:sign_out, :change_password]

  def sign_in
    user = User.find_for_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      token = Doorkeeper::AccessToken.create!(
        resource_owner_id: user.id,
        expires_in: 2.hours,
        scopes: 'public'
      )
      render json: { access_token: token.token, token_type: 'Bearer', expires_in: token.expires_in }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def sign_out
    if current_user
      current_user.tokens.destroy_all
      head :no_content
    else
      head :unauthorized
    end
  end

  def change_password
    if current_user.update_with_password(password_update_params)
      current_user.tokens.destroy_all
      head :ok
    else
      render json: { error: 'Invalid current password' }, status: :unauthorized
    end
  end

  private

  def password_update_params
    params.permit(:current_password, :new_password, :new_password_confirmation)
  end
end
