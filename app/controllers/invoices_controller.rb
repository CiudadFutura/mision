class InvoicesController < ApplicationController

	# invoices/show
	def show
		@invoice = Invoice.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @invoice }
			format.pdf { render :layout => false } # Add this line
		end
	end

end