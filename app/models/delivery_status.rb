class DeliveryStatus < ActiveRecord::Base
  belongs_to :status
  belongs_to :delivery
  belongs_to :sector
end
