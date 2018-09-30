window.onload = (function() {
    $('#new_usuario').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });

    $('#edit_usuario').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });
});

