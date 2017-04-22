class Compra < ActiveRecord::Base
  #has_and_belongs_to_many :circulos
  has_many :deliveries
  has_many :circulos, :through => :deliveries
  has_many :pedidos

	enum tipo: [:circles, :free]

	validates :nombre, :descripcion, :fecha_inicio_compras, :fecha_fin_compras,
            :fecha_fin_pagos, :fecha_entrega_compras, presence: true


  def self.ciclo_actual
    Compra.where('fecha_inicio_compras <= :today AND fecha_fin_compras >= :today', today: Time.current).first
  end

  def self.ciclo_actual_completo
    Compra.where('fecha_inicio_compras <= :today AND fecha_entrega_compras >= :today', today: Time.current).first
  end

  def self.get_last_status(sectors, delivery_id)
    last_status = 0
    sectors.each do |index, sector|
      if sector[:id] == Sector::CONSUMERS
        last_status = DeliveryStatus.where(:delivery_id => delivery_id, :sector_id => sector[:id]).order('updated_at').last
      end
    end
    return last_status

	end

	def as_json(option = {})
    { id: self.id,
      title: self.nombre,
      description: self.descripcion || '',
      start: self.fecha_inicio_compras,
      end: self.fecha_entrega_compras,

    }
  end

  def self.products_by_cycles
    count_products = {}

    current_month = 0
    current_year = 0
    last_month = 1
    last_year = 1
    last_label = ''

    totals = Compra
               .select('compras.id, sum(pedidos_details.product_qty) as cantidad,
                YEAR(compras.fecha_inicio_compras) as year,
                MONTH(compras.fecha_inicio_compras) as month,
                MONTHNAME(compras.fecha_inicio_compras) as monthname')
               .joins(pedidos: :pedidos_details)
               .group('pedidos.compra_id, year, month')
               .order('year, month')
    totals.map do |ciclo|
      unless (count_products[ciclo.year])
        count_products[ciclo.year] = {
          label: ciclo.year,
          backgroundColor: self.colors["#{ciclo.year}"],
          data: []
        }
      end
      self.labels.each do |mes|
        # next if mes.to_i + 1 <= ciclo.month and last_label.present?
        if ciclo.month == mes.to_i
          count_products[ciclo.year][:data].push(ciclo.cantidad)
          last_label = mes.to_i
          break
        elsif last_label.blank?
          count_products[ciclo.year][:data].push(0)
        end
      end
    end
    retorno = []
    count_products.each do |key, v|
      retorno.push(v)
    end
    return retorno
  end


  def get_deliveries
    deliveries = {}
    self.deliveries.map do |i|
      if i.delivery_time.present?
				if i.circulo_id.present?
					circulo_id = i.circulo_id
				else
					circulo_id = 0
				end
        deliveries[circulo_id] ={
            delivery_id: i.id,
            delivery_date: i.delivery_time,
            checkpoint: i.checkpoint,
            sorted: '',
            sectors:{}
        }
        i.delivery_statuses.map do |ds|
          deliveries[circulo_id][:sectors][ds.sector_id] = {}
          deliveries[circulo_id][:sectors][ds.sector_id][:id] = ds.sector_id
          deliveries[circulo_id][:sectors][ds.sector_id][:status] = ds.try(:status_id)
          deliveries[circulo_id][:sectors][ds.sector_id][:name] = ds.status.try(:name)
          if ds.sector_id == Sector::CONSUMERS
            deliveries[circulo_id][:sorted] =  assign_status_sort(ds.try(:status_id))
          end

        end
      end
		end
		if self.tipo != 'free'
			deliveries.sort_by { |k, v| v[:sorted] }
		end
	end

	def get_statuses
		statuses = {}
		self.deliveries.map do |delivery|
			delivery.delivery_statuses.map do |ds|

				if ds.sector_id == Sector::CONSUMERS
					if ds.status_id == Status::SCHEDULED
						statuses[ds.status.name] = ds.status
					end
					if ds.status_id == Status::ON_HOLD
						statuses[ds.status.name] = ds.status
					end
					if ds.status_id == Status::COMPLETED
						statuses[ds.status.name] = ds.status
					end
					if ds.status_id == Status::DELIVERED
						statuses[ds.status.name] = ds.status
					end
					if ds.status_id == Status::ASSIGNED
						statuses[ds.status.name] = ds.status
					end
				end
			end
		end
		return statuses
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

  def assign_status_sort(id)

    case id
      when Status::SCHEDULED
        sorted = 2
      when Status::ON_HOLD
        sorted = 1
      when Status::ASSIGNED
        sorted = 0
      when Status::DELIVERED
        sorted = 3
      else
        sorted = 4
    end

    return sorted

  end
end
