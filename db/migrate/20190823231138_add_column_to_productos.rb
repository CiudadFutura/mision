class AddColumnToProductos < ActiveRecord::Migration[5.2]
  def change
    add_column :productos, :wholesale, :boolean, default: false, after: :oculto
  end
end
