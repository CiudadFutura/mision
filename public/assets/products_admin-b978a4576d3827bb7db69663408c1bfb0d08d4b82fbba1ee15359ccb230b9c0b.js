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
            {value: 'wholesaler', text: 'Almacén'},
            {value: 'freshes', text: 'Frescos'},
            {value: 'vegetables', text: 'Verduras'},
            {value: 'fragile', text: 'Frágil'},
            {value: 'cleaning', text: 'Limpieza'}
        ]
    })


    $('#new_producto').validate({
        rules: {
            'producto[nombre]': {
                required: true,
                maxLength: 150
            },
            'producto[marca]': {
                required: true,
                maxLength: 150
            },
            'producto[stock]': {
                number: true,
                min: 0
            },
            'producto[cantidad_permitida]': {
                required: true,
                number: true,
                min: 0
            },
            'producto[orden]': {
                required: true,
                number: true,
                min: 0
            },
            'producto[precio]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[precio_super]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[precio_super]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[product_type]':{
                required: true
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $('#edit_producto').validate({
        rules: {
            'producto[nombre]': {
                required: true,
                maxLength: 150
            },
            'producto[marca]': {
                required: true,
                maxLength: 150
            },
            'producto[stock]': {
                number: true,
                min: 0
            },
            'producto[cantidad_permitida]': {
                required: true,
                number: true,
                min: 0
            },
            'producto[orden]': {
                required: true,
                number: true,
                min: 0
            },
            'producto[precio]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[precio_super]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[precio_super]': {
                required: true,
                digits: true,
                min: 0
            },
            'producto[product_type]':{
                required: true
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

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


$(document).on( "click", "#remove_bundle_product", function(e){
    e.preventDefault();
    var id = $(this).data("i");
    $("tr#" + id).remove();
});
