json.array!(@productos) do |producto|
  json.id           producto.id
  json.nombre       producto.nombre
  json.codigo       producto.codigo
  json.precio       number_to_currency(producto.precio)
  json.imagen       producto.imagen
end