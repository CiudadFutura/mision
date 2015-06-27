class AddUsers < SeedMigration::Migration
  def up

    if Rails.env.production?

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
        next if user.email.empty?
        user.save!(validate: false)
      end

      # Create Circulo and assign type to Coordinadores
      JSON.parse(open("db/json/circulos.json").read).each do |circ|
        c = Circulo.find_or_create_by(id: circ['numero']) do |circulo|
          user = Usuario.where(email: circ['email_coordinador']).first
          user.type = Usuario::COORDINADOR
          user.save!
          coordinador = Usuario.where(email: circ['email_coordinador']).first
          circulo.id = circ['numero']
          circulo.coordinador = coordinador
        end
      end

      # Assign Cirulos to each usuario
      JSON.parse(open("db/json/usuarios_purgados.json").read).each do |u|
        next if u['circulo_id'] == "null" || u['circulo_id'].nil?
        user = Usuario.where(email: u['email']).first
        user.circulo = Circulo.find(u['circulo_id']) 
        user.save!
      end
    end
    
  end

  def down

  end
end
