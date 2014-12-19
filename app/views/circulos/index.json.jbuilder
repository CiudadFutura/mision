json.array!(@circulos) do |circulo|
  json.extract! circulo, :id, :coordinador_id
  json.url circulo_url(circulo, format: :json)
end
