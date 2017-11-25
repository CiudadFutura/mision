FactoryBot.define do
  factory :transaction do
    account_id 1
    pedido_id 1
    transaction_type 1
    amount 1.5
    description "MyText"
  end
end
