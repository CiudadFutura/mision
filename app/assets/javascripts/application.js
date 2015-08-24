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
//= require_tree .

$(document).ready(function () {

  $('button[data-action]').click(function (event) {
    event.preventDefault();

    var that = $(this);

    var new_title, new_action;
    var action = that.data('action');
    var productId = that.data('productid');
    var url = 'cart/' + action + '/' + productId;

    if (action === 'add') {
      //Add a new item to cart
      new_action = 'remove';
      new_title = "Eliminar del ";
    } else if (action === 'remove') {
      //Remove item from cart
      new_action = 'add';
      new_title = "Agregar al ";
      that.parents("tr.cart-item").remove();
    }

    $.ajax({
      url: url,
      data: { cantidad: that.prev('select.cantidad').val() },
      type: 'put'
    }).done(function (data) {
      //Update menu
      $('.cart-cantidad').html(data.cantidad);
      $('.cart-ahorro').html(data.ahorro.toFixed(2) + "%");
      $('.cart-total').html(data.total);

      that.find('span.cart-action').html(new_title);
      that.data('action', new_action);
    });
  });

  $('#emails-invitados').hide();
  $('#usuario_type_coordinador').click(function () {
    $('#emails-invitados').show();
  });
  $('#usuario_type_usuario').click(function () {
    $('#emails-invitados').hide();
  });
});