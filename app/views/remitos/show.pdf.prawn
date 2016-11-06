pdf = Prawn::Document.new
pdf.text "Order ##{@remito.pedido.id}", :size => 30, :style => :bold

pdf.move_down(30)




pdf.move_down(10)

pdf.text "Total Price: #{number_to_currency(@remito.pedido.total)}", :size => 16, :style => :bold


