class AddVideoFielToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :video, :text
  end
end
