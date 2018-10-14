//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.validate.localization/messages_es
//= require raphael
//= require morris
//= require jquery.nicescroll
//= require products_admin


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



