class Circulo < ActiveRecord::Base
  #has_and_belongs_to_many :compras
  has_many :deliveries
  has_many :compras, :through => :deliveries
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios

  validate :coordinador_valido?, before: :save

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


  def self.to_csv
    CSV.generate do |csv|
      csv << ['Circulo N°', 'Coordinador', 'Coordinador Email', 'Tel/Cel']
      all.each do |circulo|
        coord = Usuario.find_by_id(circulo.coordinador_id)
        if coord.present?
          csv << [
              circulo.id,
              "#{coord.apellido}, #{coord.nombre},",
              coord.email,
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
