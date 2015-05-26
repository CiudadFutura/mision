class AddParentIdToCategoria < ActiveRecord::Migration
  def change
    add_reference :categorias, :parent, index: true
  end
end
