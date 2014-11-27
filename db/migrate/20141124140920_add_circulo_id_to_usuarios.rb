class AddCirculoIdToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :circulo_id, :integer
  end
end
