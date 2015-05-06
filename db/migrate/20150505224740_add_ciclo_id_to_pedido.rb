class AddCicloIdToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :ciclo_id, :reference, index: true
  end
end
