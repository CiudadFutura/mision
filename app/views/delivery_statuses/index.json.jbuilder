json.array!(@delivery_statuses) do |delivery_status|
  json.extract! delivery_status, :id
  json.url delivery_status_url(delivery_status, format: :json)
end
