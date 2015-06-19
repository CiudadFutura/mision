require 'csv'

class AddProveedores < SeedMigration::Migration
  def up
    codigo_proveedor = CSV.read("db/json/proveedores.csv")
    proveedores = codigo_proveedor.map{|cp| cp[1]}.uniq
    proveedores.each do |p|
      proveedor = Supplier.create!(name: p, nature: :retailer)
      puts proveedor
    end
    codigo_proveedor.each do |cp|
      proveedor = Supplier.where(name: cp[1]).first
      if proveedor
        producto = Producto.where(codigo: cp[0]).first
        if producto
          producto.supplier = proveedor
          producto.save!
        end
      end
    end
  end

  def down

  end
end
