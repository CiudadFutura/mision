class Compra < ActiveRecord::Base
  has_and_belongs_to_many :circulos
  validates :nombre, :descripcion, :fecha_inicio_compras, :fecha_fin_compras,
            :fecha_fin_pagos, :fecha_entrega_compras, presence: true

  after_initialize :init

  def self.ciclo_actual
    Compra.where('fecha_inicio_compras <= :today AND fecha_fin_compras >= :today', today: Time.current).first
  end

  def self.ciclo_actual_completo
    Compra.where('fecha_inicio_compras <= :today AND fecha_entrega_compras >= :today', today: Time.current).first
  end


  def init
    self.fecha_inicio_compras ||= Time.current
    self.fecha_fin_compras ||= Time.current
    self.fecha_fin_pagos ||= Time.current
    self.fecha_entrega_compras ||= Time.current
  end
end
