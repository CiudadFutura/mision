class AddStatusAndCheckpointToCirculosCompras < ActiveRecord::Migration
  def change
    add_column :circulos_compras, :status_id, :integer
    add_column :circulos_compras, :checkpoint, :integer
    add_column :circulos_compras, :delivery_time, :datetime

    add_column(:circulos_compras, :created_at, :datetime)
    add_column(:circulos_compras, :updated_at, :datetime)
  end
end
