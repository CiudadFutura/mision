$(document).ready(function() {
    $('#new_compra').validate({
        rules: {
            'compra[fecha_fin_compras][day]': {
                required: true,
                date: true,
                lessThan: 'compra[fecha_inicio_compras][day]'
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $('#edit_compra').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });
})