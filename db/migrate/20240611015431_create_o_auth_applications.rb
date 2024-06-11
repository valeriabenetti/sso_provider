class CreateOAuthApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :o_auth_applications do |t|
      t.string :name
      t.string :uid
      t.string :secret
      t.string :redirect_uri

      t.timestamps
    end
  end
end
