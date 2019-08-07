class CreateDeliveryStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_statuses do |t|
      t.integer :delivery_id
      t.integer :sector_id # Consumidores, Almacen, Frescos, Frutas y Verduras, Higiene y Limpieza
      t.integer :status_id  # 0 = Scheduled, 1 = On Hold, 2 = Assigned, 3 = Delivered, 4 = Completed
      t.integer :checkpoint
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
