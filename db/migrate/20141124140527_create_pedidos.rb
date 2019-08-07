class CreatePedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :pedidos do |t|
      t.text :items
      t.integer :usuario_id
      t.integer :circulo_id

      t.timestamps
    end
  end
end
