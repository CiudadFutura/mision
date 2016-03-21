json.array!(@transaction_details) do |transaction_detail|
  json.extract! transaction_detail, :id, :transaction_id, :producto_id, :price, :quantity, :subtotal
  json.url transaction_detail_url(transaction_detail, format: :json)
end
