class AddDniToUsuarios < ActiveRecord::Migration[4.2]
  def change
    add_column :usuarios, :dni, :string
  end
end
