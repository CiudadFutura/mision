class AddAdminUsers < SeedMigration::Migration
  def up
    if Rails.env.production?

      usuario = { 
        nombre: 'Administrador',
        apellido: '-', 
        password: 'Admin!QAZzaq1', 
        email: 'victoriacolectiva@misionantiinflacion.com.ar', 
        type: 'Admin' }

      user = Usuario.new(usuario)
      user.save!(validate: false)

    end
  end

  def down

  end
end
