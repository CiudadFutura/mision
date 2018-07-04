/**
 * Created by niquito on 22/02/16.
 */

window.onload = (function() {

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

	$('.thumbnails').find('.thumbnail').uniformHeight();

    $("#producto_product_type_0").on('click', function(){
        $('#bundle').empty('slow');
    });

});



$.fn.uniformHeight = function() {
	var maxHeight   = 0,
		max         = Math.max;

	return this.each(function() {
		maxHeight = max(maxHeight, $(this).height());
	}).height(maxHeight);
}

$(function () {
	$('[data-toggle="popover"]').popover({
		placement: 'auto right'
	})
});






