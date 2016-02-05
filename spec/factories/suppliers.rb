FactoryGirl.define do
  factory :supplier
  factory :supplier1, class: Supplier do
    name 'Proveedor 1'
  end
  factory :supplier2, class: Supplier do
    name 'Proveedor 2'
  end
end