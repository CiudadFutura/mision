class TransactionDetail < ActiveRecord::Base
  #belongs_to :transaction
  belongs_to :owner, foreign_key: 'transaction_id', class_name: 'Transaction'
  belongs_to :producto
end
