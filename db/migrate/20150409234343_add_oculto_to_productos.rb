class AddOcultoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :oculto, :boolean, default: false
  end
end
