$(document).ready(function() {
    $('#new_supplier').validate({
        rules:{
            calle:{
                maxlength: 100
            },
            ciudad:{
                maxlength: 100
            },
            description: {
                maxlength: 500
            }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $('#edit_supplier').validate({
        rules:{
          calle:{
            maxlength: 100
          },
          ciudad:{
            maxlength: 100
          },
          description: {
            maxlength: 500
          }
        },
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });
});
