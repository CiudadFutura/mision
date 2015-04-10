// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
// require turbolinks
//= require_tree .

$(document).ready(function() {

  $('button[data-target]').click(function (event) {
    event.preventDefault();
    $this = $(this);
    if ($this.data('target') === 'Add to') {
      url = $this.data('addurl');
      new_target = "Eliminar del ";
    } else {
      url = $this.data('removeurl');
      new_target = "Agregar al ";
      $this.parents("tr.cart-item").remove();
    }
    //console.log(url);
    //console.log($this.prev('select.cantidad').val());
    $.ajax({
      url: url,
      data: { cantidad: $this.prev('select.cantidad').val() },
      type: 'put'}).done(function(data) {
        
        $('.cart-cantidad').html(data.cantidad);
        $('.cart-ahorro').html(data.ahorro.toFixed(2)+"%");
        $('.cart-total').html(data.total);

        $this.find('span.cart-action').html(new_target);
        $this.data('target', new_target);
    });
  });

});