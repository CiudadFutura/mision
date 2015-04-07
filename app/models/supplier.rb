class Supplier < ActiveRecord::Base
  enum nature: [:wholesaler, :retailer]
end
