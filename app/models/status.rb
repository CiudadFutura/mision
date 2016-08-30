class Status < ActiveRecord::Base
  has_many :delivery_statuses
  has_many :sectors, :through => :delivery_statuses
  
  SCHEDULED = 1
  ON_HOLD = 2
  ASSIGNED = 3
  DELIVERED = 4
  COMPLETED = 5

end
