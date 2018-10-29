class Transaction < ActiveRecord::Base
  enum tipos: [:credit_note, :debit_note]
  belongs_to :account
  belongs_to :pedido
  has_many :transaction_details
  has_many :subtransacciones, class_name: 'SubTransactions',
           foreign_key: 'parent_id'

  belongs_to :parent, class_name: 'SubTransactions'

  def total
    total = 0.0
    self.transaction_details.all.each { |item| total += item.subtotal || 0.0 }
    total.to_f
  end

  def self.search(term)
    s = term.to_f
    if s.is_a? Numeric
      Transaction
      .joins(:pedido, account: :usuario)
        .where('transactions.id = :id OR (`pedidos`.id) = :id OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term',
               term: "%#{term.downcase}%", id: term)
    else
      Transaction
        .joins(:pedido, account: :usuarios)
        .where('LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term',
               term: "%#{term.downcase}%")
    end
  end


end
