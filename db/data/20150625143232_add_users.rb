class AddUsers < SeedMigration::Migration
  def up
    Usuario.delete_all
    Circulo.delete_all

    puts "Usuario"
    # puts Usuario.find(1)
    puts Usuario.all
    puts "end"
    # Create Usuarios without circulo nor type
    JSON.parse(open("db/json/usuarios_purgados.json").read).each do |u|
      user = Usuario.new()
      user.nombre   = u['nombre']
      user.apellido = u['apellido']
      user.fecha_de_nacimiento = u['fecha_de_nacimiento']
      user.calle    = u['calle']
      user.codigo_postal = u['codigo_postal']
      user.ciudad   = u['ciudad']
      user.pais     = u['pais']
      user.tel1     = u['tel1']
      user.cel1     = u['cel1']
      user.email    = u['email']
      user.dni      = u['dni']
      user.type     = Usuario::USUARIO
      user.save!(validate: false)
      puts "user_id: #{user.id}"
    end

    # Create Circulo and assign type to Coordinadores
    JSON.parse(open("db/json/circulos.json").read).each do |circ|
      c = Circulo.find_or_create_by(id: circ['numero']) do |circulo|
        #puts "circulo['coordinador_id'] #{circulo['coordinador_id']}"
        user = Usuario.find(circ['coordinador_id'])
        user.type = Usuario::COORDINADOR
        user.save!
        p user
        coordinador = Usuario.find(circ['coordinador_id'])
        circulo.id = circ['numero']
        circulo.coordinador = coordinador
      end
    end

    # Assign Cirulos to each usuario
    JSON.parse(open("db/json/usuarios_purgados.json").read).each do |u|
      user = Usuario.find(email: u['email'])
      user.circulo = Circulo.find(u['circulo_id'])
      user.save!
    end

  end

  def down

  end
end
