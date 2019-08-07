class AddColumToSuppliers < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :active, :boolean, default: false
  end
end
