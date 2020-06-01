class AddColumntToProductos < ActiveRecord::Migration[4.2]
  def change
		add_column :productos, :sale_type, :integer, after: :oculto
		add_column :productos, :remito_name, :string, after: :nombre
  end
end
