# spec/controllers/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    it 'should create a new session on successful login' do
      user = FactoryBot.create(:user)
      post :create, params: { email: user.email, password: 'password' }
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy the current session on logout' do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
