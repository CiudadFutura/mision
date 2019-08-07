class CreateCompras < ActiveRecord::Migration[5.0]
  def change
    create_table :compras do |t|
      t.string :nombre
      t.text :descripcion
      t.datetime :fecha_inicio_compras
      t.datetime :fecha_fin_compras
      t.datetime :fecha_fin_pagos
      t.datetime :fecha_entrega_compras
    end
  end
end
