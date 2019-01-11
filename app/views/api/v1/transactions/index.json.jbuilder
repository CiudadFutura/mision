json.array! @transactions do |transaction|
  json.(transaction, :id, :account_id, :pedido_id, :description, :created_at, :parent_id, :updated_at )
end