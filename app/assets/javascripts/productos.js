/**
 * Created by niquito on 22/02/16.
 */

$(document).ready(function() {

	$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

	$('.nombre').editable();
	$('.descripcion').editable();
	$('.precio').editable();
	$('.precio-super').editable();
	$('.cantidad-permitida').editable();
	$('.orden-remito').editable();
	$('.stock').editable();
	$('.oculto').editable({
		source: [
			{value: 'true', text: 'Si'},
			{value: 'false', text: 'No'},
		],
		success: function(data, config) {
			if (config=='true'){
				$('#prod-'+data.id).addClass('line-oculto');
			}else{
				$('#prod-'+data.id).removeClass('line-oculto');
			}
		}
	});
	$('.faltante').editable({
		source: [
			{value: 'true', text: 'Si'},
			{value: 'false', text: 'No'},
		]
	});
	$('#editable').editable();

	$('.pack').editable({
		source:[
			{value: '', text: 'Sin Rubro'},
			{value: 'warehouse', text: 'Almacén'},
			{value: 'freshes', text: 'Frescos'},
			{value: 'vegetables', text: 'Verduras'},
			{value: 'fragile', text: 'Frágil'},
			{value: 'cleaning', text: 'Limpieza'}
		]
	})

	$.fn.uniformHeight = function () {
		var maxHeight = 0,
			wrapper,
			wrapperHeight;

		return this.each(function () {
			wrapper = $(this).wrapInner('<div class="wrapper" />').children('.wrapper');
			wrapperHeight = wrapper.outerHeight();

			maxHeight = Math.max(maxHeight, wrapperHeight);

			wrapper.children().unwrap();

		}).height(maxHeight);
	}
});



