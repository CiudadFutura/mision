class Circulo < ActiveRecord::Base
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios

  validate :coordinador_valido?, before: :save

  after_save :assign_coordinador!

  def completo?
    self.usuarios.count >= 5
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Circulo N°', 'Coordinador', 'Coordinador Email', 'Tel/Cel']
      all.each do |circulo|
        coord = Usuario.find_by_id(circulo.coordinador_id)
        csv << [
            circulo.id,
            "#{coord.apellido}, #{coord.nombre},",
            coord.email,
            "#{coord.tel1} / #{coord.cel1}"
        ]
      end
    end
  end

  private

  def coordinador_valido?
    errors.add(:coordinador, 'El usuario no es un coordinador.') if coordinador.nil? || !coordinador.coordinador?
  end

  def assign_coordinador!
    return unless(self.try('coordinador').try('circulo'))
    self.coordinador.circulo = self
    self.coordinador.save!
  end
end
