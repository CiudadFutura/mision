class AddParentToTransaction < ActiveRecord::Migration[4.2]
  def change
    add_reference :transactions, :parent, index: true
  end
end
