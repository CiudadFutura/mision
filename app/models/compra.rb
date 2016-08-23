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
    statusList = Status.all
    self.deliveries.each do |delivery|
      deliveries[delivery.circulo_id] = {
          delivery_id: delivery.id,
          delivery_date: delivery.delivery_time,
          checkpoint: delivery.checkpoint,
          sectors: {}
      }
      statuses = DeliveryStatus.where(:delivery_id => delivery.id)

      Sector.all.each do |sector|
        status = statuses.where(:sector_id => sector.id).as_json
        deliveries[delivery.circulo_id][:sectors][sector.id.to_s] = {}
        deliveries[delivery.circulo_id][:sectors][sector.id.to_s][:id] = sector.id
        deliveries[delivery.circulo_id][:sectors][sector.id.to_s][:name] = sector.name
        deliveries[delivery.circulo_id][:sectors][sector.id.to_s][:status] = (status.present?) ? status[0]['status_id'] : nil
      end

    end

    deliveries
  end


  def init
    self.fecha_inicio_compras ||= Time.current
    self.fecha_fin_compras ||= Time.current
    self.fecha_fin_pagos ||= Time.current
    self.fecha_entrega_compras ||= Time.current
  end
end
