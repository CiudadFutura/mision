class Circulo < ActiveRecord::Base
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios

  validate :coordinador_valido?, before: :save

  after_save :assign_coordinador!

  def completo?
    self.usuarios.count >= 5
  end

  private

  def coordinador_valido?
    errors.add(:coordinador, 'El usuario no es un coordinador.') and return if self.coordinador.nil?
    errors.add(:coordinador, 'Ya se encuentra asignado.') if self.coordinador.circulo
  end

  def assign_coordinador!
    self.coordinador.circulo = self
    self.coordinador.save!
  end
end
