class AddCirculoIdToUsuarios < ActiveRecord::Migration[4.2]
  def change
    add_column :usuarios, :circulo_id, :integer
  end
end
