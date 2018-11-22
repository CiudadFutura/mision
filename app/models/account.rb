class Account < ActiveRecord::Base
  belongs_to :usuario
  has_many :transactions

  def total
    total = 0.0
    if transactions.present?
      @transactions = transactions.includes(:pedido).where('pedido_id IS NULL')
      @transactions.each { |transaction| total+= transaction.amount || 0 }
      total.to_f
    end
    return total
  end

  def self.search(term)
    s = term.to_f
    if s.is_a? Numeric
      Account
        .joins(:usuario)
        .where('accounts.id = :id OR usuarios.id = :id OR LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term ',
               term: "%#{term.downcase}%", id: term)
    else
      Account
        .joins(:usuario)
        .where('LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term',
               term: "%#{term.downcase}%")
    end
  end
end
