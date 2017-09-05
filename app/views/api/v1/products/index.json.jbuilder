json.array! @products do |product|
  json.(product, :id, :nombre, :precio, :costo, :moneda, :margen, :alicuota)
end