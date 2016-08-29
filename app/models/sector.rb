class Sector < ActiveRecord::Base
  has_many :delivery_statuses
  has_many :statuses, :through => :delivery_statuses
end
