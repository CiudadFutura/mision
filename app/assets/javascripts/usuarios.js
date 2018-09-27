var ready = function() {
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
};

$(document).on('turbolinks:load', ready);
