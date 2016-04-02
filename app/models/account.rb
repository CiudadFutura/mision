class Account < ActiveRecord::Base
  belongs_to :usuario
  has_many :transactions

  def total
    total = 0.0
    if !transactions.nil?
      transactions.each { |transaction| total+= transaction.amount || 0 }
      total.to_f
    end

  end
end
