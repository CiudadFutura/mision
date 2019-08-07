class AddVideoFielToSuppliers < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :video, :text
  end
end
