$(document).ready(function () {
    $('.thumbnails').find('.agile_top_brand_left_grid1').uniformHeight();
});


$.fn.uniformHeight = function() {
    var maxHeight   = 0,
        max         = Math.max;

    return this.each(function() {
        maxHeight = max(maxHeight, $(this).height());
    }).height(maxHeight);
}
