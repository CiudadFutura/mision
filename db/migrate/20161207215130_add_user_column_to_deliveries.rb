class AddUserColumnToDeliveries < ActiveRecord::Migration
  def change
		add_reference :circulos_compras, :usuarios, index: true, after: :compra_id, null: true
		add_reference :circulos_compras, :warehouses, index: true
  end
end
