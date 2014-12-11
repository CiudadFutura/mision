class Producto < ActiveRecord::Base
  has_and_belongs_to_many :categorias

  mount_uploader :imagen, ImagenUploader

  def cart_action(session)
    if session[:product_ids ].include?(self.id)
      'Remove from'
    else
      'Add to'
    end
  end
end
