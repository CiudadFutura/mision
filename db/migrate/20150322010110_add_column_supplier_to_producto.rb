class AddColumnSupplierToProducto < ActiveRecord::Migration[4.2]
  def change
    add_reference :productos, :supplier, index: true
  end
end
