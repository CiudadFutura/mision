// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

  $('a[data-target]').click(function (event) {
    event.preventDefault();
    $this = $(this);
    if ($this.data('target') === 'Add to') {
      url = $this.data('addurl');
      new_target = "Remove from";
    } else {
      url = $this.data('removeurl');
      new_target = "Add to";
    }
    console.log(url);
    $.ajax({
      url: url, 
      type: 'put'}).done(function(data) {
        $('.cart-count').html(data);
        $this.find('span').html(new_target);
        $this.data('target', new_target);
    });
  });

});