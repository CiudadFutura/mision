class AddDniToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :dni, :string
  end
end
