class SuppliersNewColumnForEvo < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :operation_type, :text
    add_column :suppliers, :iva_condition, :text
    add_column :suppliers, :identity_type, :text
    add_column :suppliers, :identity_number, :text
    add_column :suppliers, :inscription_number, :text
  end
end
