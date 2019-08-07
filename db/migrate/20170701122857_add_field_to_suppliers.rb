class AddFieldToSuppliers < ActiveRecord::Migration[5.0][5.0]
  def change
    add_column :suppliers, :logo, :string
  end
end
