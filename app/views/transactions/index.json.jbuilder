json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :account_id, :pedido_id, :transaction_type, :amount, :description
  json.url transaction_url(transaction, format: :json)
end
