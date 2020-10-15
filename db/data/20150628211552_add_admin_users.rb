class AddAdminUsers < SeedMigration::Migration
  def up
    if Rails.env.production?

      usuario = { 
        nombre: 'Administrador',
        apellido: '-', 
        password: 'admin', 
        email: 'admin@example.com', 
        type: 'Admin' }

      user = Usuario.new(usuario)
      user.skip_confirmation_notification!
      user.confirmed_at = Time.now
      user.save!(validate: false)

    end
  end

  def down

  end
end
