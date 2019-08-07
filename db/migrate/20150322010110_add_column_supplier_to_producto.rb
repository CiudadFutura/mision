class AddColumnSupplierToProducto < ActiveRecord::Migration[5.0]
  def change
    add_reference :productos, :supplier, index: true
  end
end
