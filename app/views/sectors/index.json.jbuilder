json.array!(@sectors) do |sector|
  json.extract! sector, :id, :name, :description
  json.url sector_url(sector, format: :json)
end
