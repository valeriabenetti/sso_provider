# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'password reset callbacks' do
    it 'should invalidate sessions before and after password reset' do
      user = FactoryBot.create(:user)
      user.invalidate_sessions_at = nil
      user.save!

      # Simulate password reset
      user.update(password: 'new_password', password_confirmation: 'new_password')

      expect(user.invalidate_sessions_at).not_to be_nil
    end
  end
end
