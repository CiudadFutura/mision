/**
 * Created by niquito on 22/02/16.
 */

(function ($) {
	$.fn.uniformHeight = function () {
		var maxHeight = 0,
				wrapper,
				wrapperHeight;

		return this.each(function () {
			wrapper = $(this).wrapInner('<div class="wrapper" />').children('.wrapper');
			wrapperHeight = wrapper.outerHeight();

			maxHeight = Math.max(maxHeight, wrapperHeight);

			wrapper.children().unwrap();

		}).height(maxHeight);
	}
})(jQuery);
