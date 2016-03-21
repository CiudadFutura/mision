class Account < ActiveRecord::Base
  belongs_to :usuario
  has_many :transactions

  def total
    total = 0.0
    transactions.each { |transaction| total += transaction.amount }
    total.to_f
  end
end
