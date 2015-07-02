require 'csv'

class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :circulo
  has_many :pedidos

  has_paper_trail

  before_create :set_default_role

  ADMIN = 'Admin'
  COORDINADOR = 'Coordinador'
  USUARIO = 'Usuario'

  def nombre
    super.nil? ? '' : super
  end

  def apellido
    super.nil? ? '' : super
  end

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
    ciclo_de_compra && self.pedidos.try(:last).try(:ciclo) == ciclo_de_compra
  end

  def pedido_del_ciclo(ciclo_de_compra)
    return nil if ciclo_de_compra.nil?
    pedido = self.pedidos.where(compra_id: ciclo_de_compra.id).first
    return pedido if pedido
    nil
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Usuario Nro', 'Apellido y Nombre', 'Email']
      all.each do |usuario|
        csv << [
          usuario.id,
          "#{usuario.apellido}, #{usuario.nombre}",
          usuario.email,
        ]
      end
    end
  end

  private
  def set_default_role
    self.type ||= Usuario::USUARIO
  end

end
