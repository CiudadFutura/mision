/**
 * Created by niquito on 22/02/16.
 */

$(document).ready(function() {

	$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

	$('.editable').editable({
		source: [
			{value: 'true', text: 'Si'},
			{value: 'false', text: 'No'},
		]
	});

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
});



