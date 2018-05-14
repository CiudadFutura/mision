class AddRolesNews < SeedMigration::Migration
  def up
    #if Rails.env.production?
      roles = [
        ['Admin', DateTime.now.to_date, DateTime.now.to_date],
        ['Usuario', DateTime.now.to_date, DateTime.now.to_date],
        ['Coordinador', DateTime.now.to_date, DateTime.now.to_date],
        ['Director', DateTime.now.to_date, DateTime.now.to_date],
        ['Proveedor', DateTime.now.to_date, DateTime.now.to_date],
      ]
      # Create Usuarios without circulo nor type
      roles.each do |name, created, updated|
        Role.create(name: name, created_at: created, updated_at: updated)
      end

    #end

  end

  def down

  end
end
