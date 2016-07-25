class Status < ActiveRecord::Base
  has_many :delivery_statuses
  has_many :deliveries, :through => :delivery_statuses
  has_many :sectors, :through => :delivery_statuses
end
