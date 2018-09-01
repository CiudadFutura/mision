$(document).on('turbolinks:load', function () {
    $('#new_usuario').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });
})