$(document).ready(function() {
    var role = 'Director';

    $(":checkbox").change(function() {
        $('#textbox1').val($(this).is(':checked'));
        $('#role_warehouse').toggle($(this).is(':checked'));
    });

    $(":checkbox").mousedown(function() {
        var current_label = $(this).prev().text();
        if (!$(this).is(':checked')) {
          if ($.trim(current_label) == role ) {
              $(this).trigger("change");
          }
        }
    });
});
