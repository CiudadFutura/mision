class AddOcultoToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :oculto, :boolean, default: false
  end
end
