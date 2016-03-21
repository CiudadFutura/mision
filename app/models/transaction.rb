class Transaction < ActiveRecord::Base
  enum transaction_type: [:credit_note, :debit_note]
  belongs_to :account
  belongs_to :pedido
  has_many :transaction_details
end
