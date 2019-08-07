class AddParentIdToCategoria < ActiveRecord::Migration[5.0]
  def change
    add_reference :categorias, :parent, index: true
  end
end
