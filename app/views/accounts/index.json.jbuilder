json.array!(@accounts) do |account|
  json.extract! account, :id, :usuario_id, :status, :balance
  json.url account_url(account, format: :json)
end
