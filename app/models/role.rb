class Role < ActiveRecord::Base
  has_many :usuario_roles
  has_many :usuarios, :through => :usuario_roles

end