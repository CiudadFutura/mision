class AddDniToUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :dni, :string
  end
end
