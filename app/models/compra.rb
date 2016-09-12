class Compra < ActiveRecord::Base
  #has_and_belongs_to_many :circulos
  has_many :deliveries
  has_many :circulos, :through => :deliveries

  validates :nombre, :descripcion, :fecha_inicio_compras, :fecha_fin_compras,
            :fecha_fin_pagos, :fecha_entrega_compras, presence: true

  after_initialize :init


  def init
    self.fecha_inicio_compras ||= Time.current
    self.fecha_fin_compras ||= Time.current
    self.fecha_fin_pagos ||= Time.current
    self.fecha_entrega_compras ||= Time.current
  end

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

  def get_deliveries
    deliveries = {}
    self.deliveries.map do |i|
      if i.delivery_time.present?
        deliveries[i.circulo_id] ={
            delivery_id: i.id,
            delivery_date: i.delivery_time,
            checkpoint: i.checkpoint,
            sorted: '',
            sectors:{}
        }
        i.delivery_statuses.map do |ds|
          deliveries[i.circulo_id][:sectors][ds.sector_id] = {}
          deliveries[i.circulo_id][:sectors][ds.sector_id][:id] = ds.sector_id
          deliveries[i.circulo_id][:sectors][ds.sector_id][:status] = ds.try(:status_id)
          deliveries[i.circulo_id][:sectors][ds.sector_id][:name] = ds.status.try(:name)
          if ds.sector_id == Sector::CONSUMERS
            deliveries[i.circulo_id][:sorted] =  assign_status_sort(ds.try(:status_id))
          end

        end
      end
    end
    deliveries.sort_by { |k, v| v[:sorted] }
  end


  private

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
