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
//= require undercore
//= require gmaps/google
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require moment
//= require fullcalendar
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require Chart.min


		$(document).ready(function () {

  $('button[data-action]').click(function (event) {
    event.preventDefault();

	  var addToCartTimeout;

    var that = $(this);

	  if (addToCartTimeout) {
		  clearTimeout(addToCartTimeout);
	  }

    var new_title, new_action;
    var action = that.data('action');
    var productId = that.data('productid');
    var url = 'cart/' + action + '/' + productId;
	  var new_class = '';
	  var old_class = '';
	  var message_box = '';

    if (action === 'add') {
      //Add a new item to cart
      new_action = 'remove';
      new_title = "Eliminar del ";
	    new_class = 'btn-danger';
	    old_class = 'btn-success';
    } else if (action === 'remove') {
      //Remove item from cart
      new_action = 'add';
      new_title = "Agregar al ";
      that.parents("tr.cart-item").remove();
	    new_class = 'btn-success';
	    old_class = 'btn-danger';
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
	    that.removeClass(old_class);
	    that.addClass(new_class);
			if (action ==='add'){
				$('#js-message-success').show().find('#js-message-product').html(that.prev('select.cantidad').val());
			}else{
				$('#js-message-delete').show();
			}

	    addToCartTimeout = setTimeout(function () {
		    if (action ==='add'){
		      $('#js-message-success').hide();
		    }else{
			    $('#js-message-delete').hide();
		    }
	    }, 3000);
    });
  });

  $('#emails-invitados').hide();
  $('#usuario_type_coordinador').click(function () {
    $('#emails-invitados').show();
  });
  $('#usuario_type_usuario').click(function () {
    $('#emails-invitados').hide();
  });
    $('#finalizar').on('click',function() {
        $(this).attr("disabled", "disabled"); }
    );
});