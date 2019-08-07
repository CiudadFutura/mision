class AddParentToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :parent, index: true
  end
end
