class Invoice < ActiveRecord::Base
	has_many :invoices_details

end