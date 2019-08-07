class AddCirculoIdToUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :circulo_id, :integer
  end
end
