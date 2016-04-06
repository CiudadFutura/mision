class Transaction < ActiveRecord::Base
  enum tipos: [:credit_note, :debit_note]
  belongs_to :account
  belongs_to :pedido
  has_many :transaction_details
  has_many :subtransacciones, class_name: "SubTransactions",
           foreign_key: "parent_id"

  belongs_to :parent, class_name: "SubTransactions"

  def total
    total = 0.0
    self.transaction_details.all.each { |item| total += item.subtotal || 0.0 }
    total.to_f
  end


end
