class Pedido < ActiveRecord::Base
  belongs_to :circulo
  belongs_to :usuario
  belongs_to :ciclo, class_name: 'Compra', foreign_key: :compra_id
  belongs_to :owner, foreign_key: 'transaction_id', class_name: 'Transaction'
	has_many :pedidos_details, dependent: :destroy

  #validates :circulo, presence: true

  has_paper_trail

  scope :evo_orders, -> (date_param) {where('updated_at >= :today', today: date_param)}

  def total
    total = 0.0
    JSON.parse(items).each { |item| total += item['total'] || 0 }
    transactions = Transaction.where(pedido_id: self.id)
    if transactions.present?
      transactions.each do |transaction|
        total -= transaction.amount
      end
    end
    total.to_f
  end

  def self.search(term)
    s = term.to_f
    if s.is_a? Numeric
      Pedido
        .joins(:usuario)
        .where('pedidos.id = :id OR LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term',
               term: "%#{term.downcase}%", id: term)
    else
      Pedido
        .joins(:usuario)
        .where('LOWER(`usuarios`.nombre) LIKE :term OR LOWER(`usuarios`.apellido) LIKE :term OR LOWER(`usuarios`.email) LIKE :term', term: "%#{term.downcase}%")
    end
  end

	def ahorro
		total_mision = total_ahorro = 0
		JSON.parse(items).each do |item|
			next if item.total == 0 || item.total_super == 0
			total_mision += item.total
			total_ahorro += item.total_super
		end
		return 0 if total_ahorro == 0
		(1 - (total_mision / total_ahorro)).to_f * 100
	end

	def cantidad
		total = 0.0
		JSON.parse(items).each do |item|
			#Rails.logger.debug(v)
			#Rails.logger.debug(_k.inspect)
			total += item['cantidad'] || 0
		end
		total.to_i
	end

  def save_in_session(session)
    carrito = Cart.new(session)
    JSON.parse(items, symbolize_names: true).each do |item|
      carrito.add(item[:producto_id], item[:cantidad])
    end
  end

  def self.pedidos_ciclos
    pedidos_por_ciclos = Pedido.joins(:ciclo)
                  .select('compras.*, max(pedidos.created_at) as most_recent, count(pedidos.id) as orders_count')
                  .group('pedidos.compra_id')
    return pedidos_por_ciclos
  end

  def self.orders_per_cycles
    Pedido.select('compras.nombre as name, count(pedidos.id) AS cycles,
              YEAR(compras.fecha_inicio_compras) as year,
              MONTH(compras.fecha_inicio_compras) as month')
    .joins(:ciclo)
    .group('year, month')
  end

  def self.orders_qty_per_year
    count_orders = {}
    last_label = ''
    orders_by_cycles = []
    totals = Pedido
               .select('count(pedidos.id) as qty, compras.id,
                  YEAR(compras.fecha_inicio_compras) as year,
                  MONTH(compras.fecha_inicio_compras) as month')
               .joins(:ciclo)
               .group('pedidos.compra_id, year, month')
               .order('year, month')

    totals.map do |ciclo|
      unless (count_orders[ciclo.year])
        count_orders[ciclo.year] = {
          label: ciclo.year,
          backgroundColor: self.colors["#{ciclo.year}"],
          data: [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
        }
      end

      if count_orders[ciclo.year][:data][ciclo.month-1][0] == 0
        count_orders[ciclo.year][:data][ciclo.month-1][0] = ciclo.qty
      else
        count_orders[ciclo.year][:data][ciclo.month-1][1] = ciclo.qty
      end

    end

    count_orders.each do |key, v|
      v[:data] = v[:data].flatten()
      orders_by_cycles.push(v)
    end

    return orders_by_cycles

  end

  def self.total_orders_circle
    (Pedido.group(:compra_id).count).to_a.last
  end

  def self.total_orders_month
    Pedido
      .select('count(pedidos.id) as qty, compras.id,
      YEAR(compras.fecha_inicio_compras) as year,
      MONTH(compras.fecha_inicio_compras) as month,
      MONTHNAME(compras.fecha_inicio_compras) as monthname',
      )
    .joins(:ciclo)
    .group('compras.id, month, year')
    .order('year, month')
    .last(3)

  end


  def has_missing?
    missing = false
    JSON.parse(self.items, symbolize_names: true).each do |item|
      producto = Producto.find(item[:producto_id]) rescue nil
      if producto.present?
        if producto.faltante?
          missing = true
          break
        else
          missing = false
        end
      end
    end
    return missing
  end

  def self.to_csv
    CSV.generate(force_quotes: true) do |csv|
      csv << ['Pedido Nro', 'Ciclo Nro', 'Usuario Nro', 'Usuario', 'email', 'Celular', 'DNI',
              'Circulo Nro', 'Retiro en:', 'Codigo Prod.', 'Nombre Prod.',
              'Cantidad']
      all.each do |pedido|

        if pedido.warehouse_id.present?
          warehouse = Warehouse.find(pedido.warehouse_id).name
        end

				transaction = Transaction.find_by_pedido_id(pedido.id)
				if transaction.present?
					csv << [
							"Nota de Crédito: Nº #{transaction.id}, $#{transaction.amount}"
					]
				end
        JSON.parse(pedido.items, symbolize_names: true).each do |item|
          begin
            producto = Producto.find(item[:producto_id])
            csv << [
              pedido.id,
              pedido.ciclo.id || 'Sin Circulo',
              pedido.usuario.try('id') || 'Sin id usuario',
							pedido.usuario.try('apellido'), pedido.usuario.try('nombre'),
							pedido.usuario.try('email') || 'Sin email',
							pedido.usuario.try('cel1') || 'Sin celular',
							pedido.usuario.try('dni') || 'Sin DNI',
              pedido.circulo.try('id') || 'Sin circulo',
              warehouse.present? ? warehouse : 'Sin depósito',
              producto.codigo,
              producto.nombre,
              item[:cantidad]
            ]
          rescue ActiveRecord::RecordNotFound
            csv << [
              pedido.id,
							pedido.ciclo.id || 'Sin Circulo',
							pedido.usuario.try('id') || 'Sin id usuario',
              pedido.usuario.try('apellido'), pedido.usuario.try('nombre'),
              pedido.circulo.try('id') || 'Sin Círculo',
              item[:producto_id],
              'ERROR',
              item[:cantidad]
            ]
          end
        end
      end
    end
  end

  def self.remitos(pedidos)
    reporte = {}

    pedidos.each do |pedido|
      JSON.parse(pedido.items).map do |i|
        producto = Producto.find(i['producto_id']) rescue nil

        if producto.present?
          circulo_id = pedido.circulo_id

          grupo = I18n.t(producto.pack)

          unless reporte.has_key?(circulo_id)
            reporte[circulo_id] = {
                grupos: {}
            }
          end

          unless reporte[circulo_id][:grupos].has_key?(grupo)
            reporte[circulo_id][:grupos][grupo] = {
                productos: {}
            }
          end

          # If the product exist on the report sums, if it's new it assignes
          if reporte[circulo_id][:grupos][grupo][:productos].has_key?(i['producto_id'])
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:qty] += i['cantidad']
          else
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']] = {}
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:name] = producto.nombre
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:qty] = i['cantidad']
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:faltante] = producto.faltante
            reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:orden_remito] = producto.orden_remito || 0
          end

        end
      end
    end

    reporte.each do |circulo_id, repo|
      repo[:grupos].each do |grupo, productos|
        productos_array = productos[:productos].values
        productos[:productos] = productos_array.sort {|a,b| a[:orden_remito] <=> b[:orden_remito]}
      end
    end

    reporte
  end

  private

  def self.colors
    {
      '2015' => 'rgba(155, 89, 182, 0.6)',
      '2016' => 'rgba(46, 204, 113, 0.6)',
      '2017' => 'rgba(192, 57, 43, 0.6)',
      '2018' => 'rgba(44, 62, 80,0.6)'
    }
  end

  def self.labels
    %w(1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12)
  end

end
