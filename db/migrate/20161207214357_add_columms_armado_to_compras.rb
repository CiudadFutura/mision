class AddColummsArmadoToCompras < ActiveRecord::Migration
  def change
		add_column :compras, :fecha_inicio_pagos, :datetime, after: :fecha_fin_compras
		add_column :compras, :fecha_inicio_armado, :datetime
		add_column :compras, :fecha_fin_armado, :datetime
		add_column :compras, :tipo, :integer
  end
end
