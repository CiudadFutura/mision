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

      Warehouse.create!(
        name: 'principal',
        description: 'almacen principal',
        address: 'San Martín 1234',
        created_at: DateTime.now.to_date, 
        updated_at: DateTime.now.to_date
      )


      UsuarioRole.create!(
        usuario_id: Usuario.find_by_email('admin@example.com').id,
        role_id: Role.find_by_name('Admin').id,
        created_at: DateTime.now.to_date, 
        updated_at: DateTime.now.to_date,
        warehouse_id: 1
      )
      Account.create!(
        usuario_id: Usuario.find_by_email('admin@example.com').id,
        status: 1,
        balance: 0,
        created_at: DateTime.now.to_date, 
        updated_at: DateTime.now.to_date
      )
      
      if !Rails.env.production?
        UsuarioRole.create!(
          usuario_id: Usuario.find_by_email('coordinador@example.com').id,
          role_id: Role.find_by_name('Coordinador').id,
          created_at: DateTime.now.to_date, 
          updated_at: DateTime.now.to_date,
          warehouse_id: 1
        )
        Account.create!(
          usuario_id: Usuario.find_by_email('coordinador@example.com').id,
          status: 1,
          balance: 0,
          created_at: DateTime.now.to_date, 
          updated_at: DateTime.now.to_date
        )

        UsuarioRole.create!(
          usuario_id: Usuario.find_by_email('usuario@example.com').id,
          role_id: Role.find_by_name('Usuario').id,
          created_at: DateTime.now.to_date, 
          updated_at: DateTime.now.to_date,
          warehouse_id: 1
        )
        Account.create!(
          usuario_id: Usuario.find_by_email('usuario@example.com').id,
          status: 1,
          balance: 0,
          created_at: DateTime.now.to_date, 
          updated_at: DateTime.now.to_date
        )
      end

    #end

  end

  def down

  end
end
