class AddColumnFreeToProductosTable < ActiveRecord::Migration
  def change
		add_column :productos, :sale_type, :integer
		add_column :productos, :remito_name, :string
  end
end
