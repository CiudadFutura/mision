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
        $('#bundle').hide('slow');
    });

    $("#producto_product_type_1").on('click', function(){
        $('#bundle').show('slow');
    });

    $('#search').bind('autocompleteselect', function() {
        $('#addItem').removeAttr('disabled');
    });

    $('#addItem').on('click', function () {
        $.ajax({
            url : '/productos/bundle_item',
            type : 'GET',
            dataType : 'json',
            data: {id: $('#my_producto_id').val()},
            success : function(data) {
                $("#search").val("");
                $("#addItem").attr('disabled', 'disabled');
                $("#bundleItems tbody").append('<tr><td>' +
                    '<input id="item_'+data.id+'" type="hidden" name="producto[bundle_products_attributes]['+data.id+'][item_id]" ' +
                    'value="'+data.id+'"/>'+data.id+'</td><td>'+
                    data.nombre+'</td><td>'+data.codigo+'</td><td>'+data.precio+'</td>' +
                    '<td><input id="qty_'+data.id+'" name="producto[bundle_products_attributes]['+data.id+'][qty]" value="" /></td></tr>');
            },
            error : function() {
                alert('No se pudo agregar el producto!!');
            },
            complete: function (data) {
                //alert(data);
            }
        });
    });



});

$(document).on( "click", "#remove_bundle_product", function(e){
    e.preventDefault();
    var id = $(this).data("i");
    $("tr#" + id).remove();
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








