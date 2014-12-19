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
end
