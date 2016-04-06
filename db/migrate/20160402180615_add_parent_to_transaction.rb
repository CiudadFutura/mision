class AddParentToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :parent, index: true
  end
end
