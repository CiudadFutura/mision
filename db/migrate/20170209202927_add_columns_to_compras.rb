class AddColumnsToCompras < ActiveRecord::Migration
  def change
		add_column :compras, :fecha_inicio_pagos, :datetime, after: :fecha_fin_compras
		add_column :compras, :fecha_inicio_armado, :datetime, after: :fecha_inicio_pagos
		add_column :compras, :fecha_fin_armado, :datetime, after: :fecha_inicio_armado
		add_column :compras, :tipo, :integer, after: :fecha_entrega_compras
  end
end
