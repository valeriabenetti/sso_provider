class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant', foreign_key: :resource_owner_id, dependent: :destroy
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :destroy

  def generate_access_token
    Doorkeeper::AccessToken.create!(resource_owner_id: id).token
  end

  def revoke_tokens!
    access_tokens.update_all(revoked_at: Time.current)
  end
end
