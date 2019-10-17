class AddColumnToUsuarioTable < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :warehouse_id, :integer
  end
end
