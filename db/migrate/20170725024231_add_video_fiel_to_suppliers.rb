class AddVideoFielToSuppliers < ActiveRecord::Migration[4.2]
  def change
    add_column :suppliers, :video, :text
  end
end
