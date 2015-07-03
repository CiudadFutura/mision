require 'csv'

class AddCirculosNuevos < SeedMigration::Migration
  def up
    if Rails.env.production?

      circulos_nuevos = CSV.read("db/json/circulos_nuevos.csv")

      circulos = []
      usuarios = []

      circulos_nuevos.each do |row|
        next if row[9].nil? || row[9].empty?
        usuarios << {
          nombre: row[7],
          apellido: row[8],
          email: row[9],
          type: (row[11] == 'coordinador') ? Usuario::COORDINADOR : Usuario::USUARIO,
          circulo_id: row[0]
        }
        if row[11] == 'coordinador'
          circulos << {circulo_id: row[0], coordinador_email: row[3]}
        end
      end

      usuarios.each do |usuario|
        user = Usuario.new
        user.nombre = usuario[:nombre]
        user.apellido = usuario[:apellido]
        user.email = usuario[:email]
        user.type = usuario[:type]
        user.skip_confirmation_notification!
        user.confirmed_at = Time.now
        user.save!(validate: false)
      end

      circulos.each do |circulo|
        circ = Circulo.new
        circ.id = circulo[:circulo_id]
        user = Coordinador.find_by(email: circulo[:coordinador_email])
        circ.coordinador = user
        circ.save!
      end

      # Assign Cirulos to each usuario
      usuarios.each do |usuario|
        user = Usuario.find_by(email: usuario[:email])
        user.circulo = Circulo.find(usuario[:circulo_id])
        user.save!
      end
    end

  end

  def down

  end
end
