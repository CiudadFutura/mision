json.array!(@productos) do |producto|
  json.extract! producto, :id, :precio, :nombre, :descripcion, :precio_super, :cantidad_permitida
  json.url producto_url(producto, format: :json)
end
