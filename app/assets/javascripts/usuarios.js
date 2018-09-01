$(document).on('turbolinks:load', function () {
    $('#edit_usuario').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'
    });
})