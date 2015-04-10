json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :address, :nature
  json.url supplier_url(supplier, format: :json)
end
