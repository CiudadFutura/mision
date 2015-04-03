json.array!(@compras) do |compra|
  json.extract! compra, :id
  json.url compra_url(compra, format: :json)
end
