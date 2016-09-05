// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {

	var amount = $('#transaction_amount');
	var description = $('#transaction_description');

	$('[data-item] input:checkbox').change(function (event) {
		var total = 0;
		var detalle = $('#hidden-description').val();
		$('[data-item]').each(function(i, obj) {
			if ($(obj).find('input:checkbox:checked').length) {
				total += $(obj).find('[data-item-total]').data('item-total');
				detalle += 'Producto: '+ $(obj).find('[data-item-nombre]').data('item-nombre') + '\t' +
				'Cantidad: '+ $(obj).find('[data-item-cantidad]').data('item-cantidad') + '\t' +
				'Precio: '+ $(obj).find('[data-item-precio]').data('item-precio') +'\n';
			}
		});
		amount.val(total.toFixed(2));
		description.val(detalle);
	});

	$("#additem" ).click(function() {
		$("#form-add-item").toggle();
	});

	$("#agregar").click(function(){
		var nombre = $("#prod-nombre");
		var precio = $("#prod-precio");
		var cantidad = $("#prod-cantidad");
		var detalle = $('#transaction_description').val();
		var total = $('#transaction_amount').val();
		var subTotal = 0;
		var detalleadd = $('#hidden-description').val() + detalle + 'Producto: '+ nombre.val() + '\t' +
				'Cantidad: '+ cantidad.val() + '\t' +
				'Precio: $'+ precio.val();
		subTotal = (cantidad.val())*(precio.val());
		var index = 0;
		if ($("#index").val() == undefined){
			$("#index").val(0);
		}else{
			index = $("#index").val() + 1;
		}

		var row = '<tr data-item><td><input id="no_producto_ids_" name="no_producto_ids[]" type="checkbox" value="0" checked="checked" <input id="index" type="hidden" value="'+index+'"></td>' +
				'<td data-item-nombre="'+nombre.val()+'"><input class="form-control" id="producto_nombre" name="no_producto_nombre_'+index+'" type="hidden" value="'+nombre.val()+'">'+nombre.val()+'</td>' +
				'<td data-item-precio="'+precio.val()+'" class="text-right"><input class="form-control" id="producto_precio" name="no_producto_precio_'+index+'" type="hidden" value="'+precio.val()+'">$'+precio.val()+'</td>' +
				'<td data-item-cantidad="'+cantidad.val()+'" class="text-right"><input class="form-control" id="producto_cantidad" name="no_producto_cantidad_'+index+'" type="hidden" value="'+cantidad.val()+'">'+cantidad.val()+'</td>' +
				'<td class="text-right" data-item-total="'+subTotal+'"><input class="form-control" id="producto_total" name="no_producto_total_'+index+'" type="hidden" value="'+subTotal+'">$'+subTotal+'</td></tr>';
		$("#pord-pedidos").append(row);
		$('#transaction_amount').val(total + subTotal);
		$('#transaction_description').val(detalleadd);
		nombre.val('');
		precio.val('');
		cantidad.val('');
		$("#form-add-item").toggle();
	})

	$('input').bind('keypress', function (event) {
		var regex = new RegExp("^(\d|-)?(\d|,)*\.?\d*$");
		var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		if (!regex.test(key)) {
			event.preventDefault();
			return false;
		}
	});

});


