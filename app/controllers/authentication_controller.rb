class AuthenticationController < ApplicationController
  before_action :authenticate_user!, only: [:sign_out, :change_password]

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      sign_in(user)
      render json: { message: 'Signed in successfully.', access_token: user.generate_access_token }
    else
      render json: { error: 'Invalid email or password.' }, status: :unauthorized
    end
  end

  def sign_out
    sign_out(current_user)
    render json: { message: 'Signed out successfully.' }
  end

  def change_password
    if current_user.valid_password?(params[:current_password])
      current_user.update(password: params[:new_password])
      render json: { message: 'Password changed successfully.' }
    else
      render json: { error: 'Current password is invalid.' }, status: :unauthorized
    end
  end
end
