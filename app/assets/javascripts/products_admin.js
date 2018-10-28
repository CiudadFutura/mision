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
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $('#edit_producto').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

});