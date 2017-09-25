json.array! @users do |user|
  json.(user, :id, :email, :nombre, :apellido, :dni, :nombre_iva, :calle, :ciudad, :tel1, :cel1, :circulo_id, :codigo_vendedor,
    :tipo_operacion, :inscripcion_iva, :tipo_identificacion, :numero_identificacion, :codigo_transporte,
    :codigo_clasificacion, :updated_at )
end