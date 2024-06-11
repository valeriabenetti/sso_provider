# spec/requests/oauth_spec.rb
require 'rails_helper'

RSpec.describe 'OAuth flow', type: :request do
  describe 'GET /oauth/authorize' do
    it 'should authorize the client application' do
      client = FactoryBot.create(:oauth_application)
      user = FactoryBot.create(:user)
      post '/oauth/authorize', params: { client_id: client.uid, response_type: 'code', redirect_uri: client.redirect_uri, state: 'random_state', scope: 'public' }
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user.email)
    end
  end

  describe 'POST /oauth/token' do
    it 'should issue an access token' do
      client = FactoryBot.create(:oauth_application)
      user = FactoryBot.create(:user)
      post '/oauth/token', params: { client_id: client.uid, client_secret: client.secret, grant_type: 'password', username: user.email, password: 'password' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('access_token')
    end
  end
end
