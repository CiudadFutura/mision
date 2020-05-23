class AddColumnsToUsuarios < ActiveRecord::Migration[4.2]
  def change
    add_column :usuarios, :nombre_iva, :text
    add_column :usuarios, :zona, :text
    add_column :usuarios, :codigo_vendedor, :text
    add_column :usuarios, :tipo_operacion, :text
    add_column :usuarios, :inscripcion_iva, :text
    add_column :usuarios, :tipo_identificacion, :text
    add_column :usuarios, :numero_identificacion, :text
    add_column :usuarios, :numero_ingresos_brutos, :text
    add_column :usuarios, :codigo_transporte, :text
    add_column :usuarios, :codigo_clasificacion, :text
  end
end
