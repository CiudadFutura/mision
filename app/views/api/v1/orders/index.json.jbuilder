json.array! @orders do |order|
  json.(order, :id,:usuario_id, :circulo_id, :compra_id, :updated_at, :items )
end