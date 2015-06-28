class ChangeTelephoneNum < SeedMigration::Migration
  def up
    if Rails.env.production?
      JSON.parse(open("db/json/usuarios_purgados.json").read).each do |u|
        user = Usuario.where(email: u['email']).first
        user.tel1 = u['tel1']
        user.cel1 = u['cel1'] 
        user.save!
      end
    end
  end

  def down

  end
end
