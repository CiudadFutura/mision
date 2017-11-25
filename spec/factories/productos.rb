saved_single_instances = {}
#Find or create the model instance
single_instances = lambda do |factory_key|
  begin
    saved_single_instances[factory_key].reload
  rescue NoMethodError, ActiveRecord::RecordNotFound
    #was never created (is nil) or was cleared from db
    saved_single_instances[factory_key] = FactoryBot.create(factory_key)  #recreate
  end

  return saved_single_instances[factory_key]
end

FactoryBot.define do
  factory :prod1, class: Producto do
    codigo 1
    nombre 'prod1'
    supplier { single_instances[:supplier1] }
  end
  factory :prod2, class: Producto do
    id 2
    nombre 'prod2'
    codigo 2
    supplier { single_instances[:supplier1] }
  end
  factory :prod3, class: Producto do
    id 3
    nombre 'prod3'
    codigo 3
    supplier { single_instances[:supplier2] }
  end
end