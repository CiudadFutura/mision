window.onload = (function() {
    $('#new_usuario').validate({
        rules: {
            'usuario[password]': {
                minlength: 8
            },
            'usuario[password_confirmation]': {
                equalTo: "#usuario_password",
                minlength: 8
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });
});



