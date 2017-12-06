json.array!(@productos) do |producto|
  json.nombre        producto.nombre
  json.pack          producto.pack
  json.precio        number_to_currency(producto.precio)
  json.imagen        producto.imagen
end