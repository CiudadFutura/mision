class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :usuario, index: true
      t.string :provider
      t.string :uid
			t.string :email
			t.string :name
			t.string :oauth_token
			t.datetime :oauth_expired_at

      t.timestamps
    end
  end
end
