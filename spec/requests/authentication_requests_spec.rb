require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /sign_in' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    it 'signs user in with valid credentials' do
      post '/sign_in', params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      expect(json_response['access_token']).to be_present
    end

    it 'returns unauthorized with invalid credentials' do
      post '/sign_in', params: { email: 'invalid@example.com', password: 'invalid_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /sign_out' do
    let!(:user) { create(:user, :with_tokens) }

    it 'signs user out' do
      sign_in(user)
      delete '/sign_out'
      expect(response).to have_http_status(:no_content)
    end

    it 'requires authentication for sign out' do
      delete '/sign_out'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH /change_password' do
    let!(:user) { create(:user, password: 'password') }

    it 'changes user password' do
      sign_in(user)
      patch '/change_password', params: { current_password: 'password', new_password: 'new_password' }
      expect(response).to have_http_status(:success)
    end

    it 'requires authentication for changing password' do
      patch '/change_password', params: { current_password: 'password', new_password: 'new_password' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized with invalid current password' do
      sign_in(user)
      patch '/change_password', params: { current_password: 'invalid_password', new_password: 'new_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
