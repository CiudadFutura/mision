class AddFieldToSuppliers < ActiveRecord::Migration[4.2]
  def change
    add_column :suppliers, :logo, :string
  end
end
