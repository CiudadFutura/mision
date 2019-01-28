json.array! @transactions do |transaction|
  user = transaction.account.usuario
  json.(transaction, :id, :amount, :description, :account_id, :pedido_id, :created_at, :parent_id, :updated_at )
  json.name_user(user)
end