class UsuarioRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :usuario

end