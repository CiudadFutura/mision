class AddColumToSuppliers < ActiveRecord::Migration[4.2]
  def change
    add_column :suppliers, :active, :boolean, default: false
  end
end
