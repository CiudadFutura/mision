class Transaction < ActiveRecord::Base
  enum transaction_type: [:credit_note, :debit_note]
  belongs_to :account
  belongs_to :pedido
  has_many :transaction_details

  def total
    total = 0.0
    self.transaction_details.all.each { |item| total += item.subtotal || 0.0 }
    total.to_f
  end

end
