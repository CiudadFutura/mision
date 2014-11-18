json.array!(@categoria) do |categoria|
  json.extract! categoria, :id, :nombre, :descripcion
  json.url categoria_url(categoria, format: :json)
end
