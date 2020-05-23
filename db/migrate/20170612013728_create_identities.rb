class CreateIdentities < ActiveRecord::Migration[4.2]
  def change
    create_table :identities do |t|
      t.integer :usuario_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :refresh_token
      t.string :name
      t.string :email
      t.string :nickname
      t.string :image
      t.string :phone
      t.string :urls
      t.datetime :expires_at

      t.timestamps
    end
  end
end
