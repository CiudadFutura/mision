//= require jquery
//= require morris
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.validate.localization/messages_es
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails


$(document).ready(function() {

    var toggle = true;

    $(".sidebar-icon").click(function() {
        if (toggle)
        {
            $(".page-container").addClass("sidebar-collapsed").removeClass("sidebar-collapsed-back");
            $("#menu span").css({"position":"absolute"});
        }
        else
        {
            $(".page-container").removeClass("sidebar-collapsed").addClass("sidebar-collapsed-back");
            setTimeout(function() {
                $("#menu span").css({"position":"relative"});
            }, 400);
        }

        toggle = !toggle;
    });

});



