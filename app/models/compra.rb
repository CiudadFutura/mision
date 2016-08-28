class Compra < ActiveRecord::Base
  #has_and_belongs_to_many :circulos
  has_many :deliveries
  has_many :circulos, :through => :deliveries

  validates :nombre, :descripcion, :fecha_inicio_compras, :fecha_fin_compras,
            :fecha_fin_pagos, :fecha_entrega_compras, presence: true

  after_initialize :init

  def self.ciclo_actual
    Compra.where('fecha_inicio_compras <= :today AND fecha_fin_compras >= :today', today: Time.current).first
  end

  def self.ciclo_actual_completo
    Compra.where('fecha_inicio_compras <= :today AND fecha_entrega_compras >= :today', today: Time.current).first
  end

  def get_deliveries
    deliveries = {}
    self.deliveries.map do |i|
      if i.delivery_time.present?
        deliveries[i.circulo_id] ={
            delivery_id: i.id,
            delivery_date: i.delivery_time,
            checkpoint: i.checkpoint,
            sectors:{}
        }
        i.delivery_statuses.map do |ds|
          deliveries[i.circulo_id][:sectors][ds.sector_id] = {}
          deliveries[i.circulo_id][:sectors][ds.sector_id][:id] = ds.sector_id
          deliveries[i.circulo_id][:sectors][ds.sector_id][:status] = ds.try(:status_id)
          deliveries[i.circulo_id][:sectors][ds.sector_id][:name] = ds.status.try(:name)

        end
      end
    end
    deliveries
    #deliveries = self.deliveries.collect(&:delivery_statuses).flatten.uniq
  end


  def init
    self.fecha_inicio_compras ||= Time.current
    self.fecha_fin_compras ||= Time.current
    self.fecha_fin_pagos ||= Time.current
    self.fecha_entrega_compras ||= Time.current
  end
end
