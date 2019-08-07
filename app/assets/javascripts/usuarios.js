window.onload = (function() {

    var regex = /^(?:(?:00)?549?)?0?(?:11|[2368]\d)(?:(?=\d{0,2}15)\d{2})??\d{8}$/;

    $('#new_usuario').validate({
        rules: {
            'usuario[dni]': {
                number: true
            },
            'usuario[cel1]': {
                number: true,
                regx: regex
            },
            'usuario[tel1]': {
                number: true
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });

    $('#edit_usuario').validate({
        rules: {
            'usuario[dni]': {
                number: true
            },
            'usuario[cel1]': {
                number: true,
                regx: regex
            },
            'usuario[tel1]': {
                number: true
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });

    $('#new_circulo').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });

    $('#add-myself').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });

    $.validator.addMethod("regx", function(value, element, regexpr) {
        return regexpr.test(value);
    }, "Ingrese el formato correcto Ej: 3416555555.");
});

