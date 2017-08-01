class AddColumToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :active, :boolean, default: false
  end
end
