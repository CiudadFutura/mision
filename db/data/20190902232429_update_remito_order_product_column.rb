require 'csv'

class UpdateRemitoOrderProductColumn < SeedMigration::Migration
  def up
    file = File.read("db/json/updateProductos.csv")
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      producto = Producto.find_by_codigo(row['Codigo'])
      if producto.present?
        producto.orden_remito = row['Acopio']
        producto.save!
      end
    end
  end
end
