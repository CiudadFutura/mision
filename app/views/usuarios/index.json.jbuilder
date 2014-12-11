json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :nombre, :apellido, :fecha_de_nacimiento, :email, :calle, :codigo_postal, :ciudad, :pais, :tel1, :cel1, :type
  json.url usuario_url(usuario, format: :json)
end
