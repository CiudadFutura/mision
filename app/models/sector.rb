class Sector < ActiveRecord::Base
  has_many :delivery_statuses
  has_many :statuses, :through => :delivery_statuses

  STORE = 1
  FRAGILE = 2
  FRESH = 3
  FRUITS_VEGETABLES = 4
  HYGIENE_CLEANING = 5
  CONSUMERS = 6

end
