class AddColumnSupplierToProducto < ActiveRecord::Migration
  def change
    add_reference :productos, :supplier, index: true
  end
end
