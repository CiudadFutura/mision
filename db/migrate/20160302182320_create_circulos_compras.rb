class CreateCirculosCompras < ActiveRecord::Migration[4.2]
  def change
    create_table :circulos_compras do |t|
      t.belongs_to :circulo
      t.belongs_to :compra
    end
  end
end
