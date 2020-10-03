

window.onload = (function() {

    $('.thumbnails').find('.agile_top_brand_left_grid1').uniformHeight();


    $('#addItem').on('click', function () {
        $.ajax({
            url : '/productos/bundle_item',
            type : 'GET',
            dataType : 'json',
            data: {id: $('#my_producto_id').val()},
            success : function(data) {
                $("#search").val("");
                $("#addItem").attr('disabled', 'disabled');
                $("#bundleItems tbody").append('<tr id="'+data.id+'"><td>' +
                    '<input id="item_'+data.id+'" type="hidden" name="producto[bundle_products_attributes]['+data.id+'][item_id]" ' +
                    'value="'+data.id+'"/>'+data.id+'</td><td>'+
                    data.nombre+'</td><td>'+data.codigo+'</td><td>'+data.precio+'</td>' +
                    '<td><input id="qty_'+data.id+'" name="producto[bundle_products_attributes]['+data.id+'][qty]" value="" /></td>' +
                    '<td><a href="#" id="remove_bundle_product" data-i="'+data.id+'">Eliminar</a></td></tr>');
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

(function($) {
    $.fn.uniformHeight = function() {
        var maxHeight   = 0,
            max         = Math.max;

        return this.each(function() {
            maxHeight = max(maxHeight, $(this).height());
        }).height(maxHeight);
    }
})(jQuery);




