class Circulo < ActiveRecord::Base
  #has_and_belongs_to_many :compras
  has_many :deliveries
  has_many :compras, :through => :deliveries
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios
  belongs_to :warehouse

  before_save :coordinador_valido?

  after_save :assign_coordinador!

  def completo?
    self.usuarios.count >= 5
  end

  def self.get_delivery(compra_id)
    Delivery.where('compra_id = ? AND delivery_time IS NULL', compra_id,)
	end

	def next_delivery
		self.compras
				.where('compras.fecha_inicio_compras >= ?', Date.today).order('compras.fecha_inicio_compras')
  end

  def self.with_warehouses
    Circulo.where('warehouse_id is not null').count
  end

  def self.search(term)
    s = term.to_f
    role = Role.find_by_name(Usuario::COORDINADOR)
    if s.is_a? Numeric
      Circulo
        .joins(:warehouse, usuarios: :roles)
        .where('circulos.id = :id OR LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term OR  (`circulos`.id) LIKE :term OR LOWER(`warehouses`.name) LIKE :term AND usuario_roles.role_id = :role ',
               term: "%#{term.downcase}%", id: term, role: role.id)
        .distinct
    else
      Circulo
        .joins(:warehouse, usuarios: :roles)
        .where('LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term OR  (`circulos`.id) LIKE :term OR LOWER(`warehouses`.name) LIKE :term AND usuario_roles.roles_id = :role',
               term: "%#{term.downcase}%", role: role.id)
        .distinct
    end
  end


  def self.to_csv
    CSV.generate do |csv|
      csv << ['Circulo N°', 'Coordinador', 'Coordinador Email', 'Distrito', 'Tel/Cel']
      all.each do |circulo|
        coord = Usuario.find_by_id(circulo.coordinador_id)
        if coord.present?
          csv << [
              circulo.id,
              "#{coord.apellido}, #{coord.nombre},",
              coord.email,
              circulo.try('warehouse_id') ? circulo.warehouse.name : '',
              "#{coord.tel1} / #{coord.cel1}"
          ]
        end

      end
    end
  end

  private

  def coordinador_valido?
    errors.add(:coordinador, 'El usuario no es un coordinador.') if coordinador.nil? || !coordinador.coordinador?
  end

  def assign_coordinador!
    return unless(self.try('coordinador').try('circulo'))
    self.coordinador.circulo = self
    self.coordinador.save!
  end
end
