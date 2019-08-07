class AddOcultoToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :oculto, :boolean, default: false
  end
end
