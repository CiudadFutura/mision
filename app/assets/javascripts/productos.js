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

var app = window.app = {};

app.Products = function () {
    this._input = $('#products-search-txt');
    this._initAutocomplete();
}

app.Products.prototype = {
    _initAutocomplete: function() {
        this._input
            .autocomplete({
                source: '/productos/search',
                appendTo: '#products-search-results',
                select: $.proxy(this._select, this)
                })
            .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _select: function(e, ui) {
        debugger;
        this._input.val(ui.item.nombre + ' - ' + ui.item.precio);
        return false;
    },

    _render: function(ul, item) {
        var markup = [
            '<span class="img">',
            '<img src="' + item.imagen + '" />',
            '</span>',
            '<span class="title">' + item.nombre + '</span>',
            '<span class="author">' + item.codigo + '</span>',
            '<span class="price">' + item.precio + '</span>'
        ];
        return $('<li>')
            .append(markup.join(''))
            .appendTo(ul);
    }

};




