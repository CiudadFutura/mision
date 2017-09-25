json.array! @suppliers do |supplier|
  json.(supplier, :id, :name, :calle, :ciudad, :codigo_postal, :telefono, :nombre_contacto, :operation_type,
    :iva_condition, :identity_type, :identity_number, :inscription_number, :updated_at)
end