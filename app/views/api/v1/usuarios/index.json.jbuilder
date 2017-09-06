json.array! @users do |user|
  json.(user, :id, :email, :nombre, :nombre_iva, :calle, :ciudad, :tel1, :cel1, :zona, :codigo_vendedor,
    :tipo_operacion, :inscripcion_iva, :tipo_identificacion, :numero_identificacion, :codigo_transporte,
    :codigo_clasificacion )
end