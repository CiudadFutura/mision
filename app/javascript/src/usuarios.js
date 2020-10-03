window.onload = (function() {


    $('#new_usuario').validate({
        rules: {
            'usuario[dni]': {
                number: true
            },
            'usuario[cel1]': {
                number: true
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
                number: true
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
});

