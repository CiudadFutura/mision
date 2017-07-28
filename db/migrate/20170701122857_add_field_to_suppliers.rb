class AddFieldToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :logo, :string
  end
end
