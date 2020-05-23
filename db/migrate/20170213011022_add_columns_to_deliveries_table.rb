class AddColumnsToDeliveriesTable < ActiveRecord::Migration[4.2]
  def change
		add_reference :circulos_compras, :usuarios, index: true, after: :compra_id, null: true
		add_reference :circulos_compras, :warehouses, index: true, after: :usuarios_id
  end
end
