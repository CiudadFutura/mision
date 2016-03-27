// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {

	var amount = $('#transaction_amount');
	var description = $('#transaction_description');

	$('[data-item] input:checkbox').change(function (event) {
		var total = 0;
		var detalle = '';
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

});
