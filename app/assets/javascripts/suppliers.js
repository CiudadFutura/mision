
var ready;
ready = function() {
    $('.suppliers').find('.supplier').uniformHeight();
};

(function($) {
    $.fn.uniformHeight = function() {
        var maxHeight   = 0,
            max         = Math.max;

        return this.each(function() {
            maxHeight = max(maxHeight, $(this).height());
        }).height(maxHeight);
    }
})(jQuery);

$(document).on('turbolinks:load', ready);
