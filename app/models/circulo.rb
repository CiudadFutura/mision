class Circulo < ActiveRecord::Base
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios

  def completo?
    self.usuarios.count >= 5
  end
end
