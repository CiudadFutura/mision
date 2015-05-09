class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :circulo
  has_many :pedidos

  ADMIN = 'Admin'
  COORDINADOR = 'Coordinador'
  USUARIO = 'Usuario'

  def self.types
    [ADMIN, COORDINADOR, USUARIO]
  end

  def admin?
    type == ADMIN
  end

  def coordinador?
    type == COORDINADOR
  end

  def usuario?
    type == USUARIO
  end

  def pedido?(ciclo_de_compra)
    # raise "andres" if self.nombre == 'andres'
    ciclo_de_compra && self.pedidos.try(:last).try(:ciclo) == ciclo_de_compra
  end

end
