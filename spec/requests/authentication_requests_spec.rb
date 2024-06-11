require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /sign_in' do
    it 'signs user in with valid credentials' do
      user = create(:user, email: 'test@example.com', password: 'password')
      post '/sign_in', params: { email: 'test@example.com', password: 'password' }
      expect(response).to have_http_status(:success)
      expect(json_response['access_token']).to be_present
    end

    it 'returns unauthorized with invalid credentials' do
      post '/sign_in', params: { email: 'invalid@example.com', password: 'invalid_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /sign_out' do
    it 'signs user out' do
      user = create(:user)
      sign_in(user)
      delete '/sign_out'
      expect(response).to have_http_status(:success)
    end

    it 'requires authentication for sign out' do
      delete '/sign_out'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH /change_password' do
    it 'changes user password' do
      user = create(:user, password: 'password')
      sign_in(user)
      patch '/change_password', params: { current_password: 'password', new_password: 'new_password' }
      expect(response).to have_http_status(:success)
    end

    it 'requires authentication for changing password' do
      patch '/change_password', params: { current_password: 'password', new_password: 'new_password' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized with invalid current password' do
      user = create(:user, password: 'password')
      sign_in(user)
      patch '/change_password', params: { current_password: 'invalid_password', new_password: 'new_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
