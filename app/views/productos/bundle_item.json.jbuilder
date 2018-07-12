  json.id           @items.id
  json.nombre       @items.nombre
  json.codigo       @items.codigo
  json.precio       number_to_currency(@items.precio)
  json.imagen       @items.imagen
