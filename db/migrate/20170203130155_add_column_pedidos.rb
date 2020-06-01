class AddColumnPedidos < ActiveRecord::Migration[4.2]
  def change
		add_column :pedidos, :total_discount, :float
		add_column :pedidos, :total, :float
		add_column :pedidos, :total_products, :integer
		add_column :pedidos, :invoice_number, :integer
		add_column :pedidos, :invoice_date, :datetime
		add_column :pedidos, :active, :boolean
		add_column :pedidos, :saving, :float
  end
end
