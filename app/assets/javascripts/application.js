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
    var current_qty = that.data('qty');
    var url = 'cart/' + action + '/' + productId;
    var actionMessage = '';
	  var resultClass = '';
	  var accion = that.data('accion');

    if (action === 'add') {
      that.attr('disabled', 'disabled');
	    actionMessage='Se agregó 1 producto';
      if(current_qty == 0){
        $('#remove_id'+productId).removeAttr('disabled');
      }
	    $('#remove_id'+productId).data('qty', current_qty+1);
	    that.data('qty',current_qty+1);
	    resultClass='success';
    } else if (action === 'remove') {
      that.attr('disabled', 'disabled');
	    actionMessage='Se eliminó 1 producto';
	    if(current_qty == 1){
		    that.attr('disabled', 'disabled');
	    }
	    $('#add_id'+productId).data('qty', current_qty-1);
	    that.data('qty',current_qty-1);
	    resultClass='danger';
    }

    $.ajax({
      url: url,
      data: { cantidad: current_qty, accion: accion },
      type: 'put'
    }).done(function (data) {
      //Update menu
      $('.cart-cantidad').html(data.cantidad);
      $('.cart-ahorro').html(data.ahorro.toFixed(2) + "%");
      $('.cart-total').html(data.total);

	    $('#mensaje_'+productId).html('<div class="alert alert-'+resultClass+'"><button type="button" class="close">×</button>'+ actionMessage +' </div>');


      window.setTimeout(function () {
        $(".alert").fadeTo(500, 0).slideUp(300, function () {
          $(this).remove();
	        if(action==='remove' && that.data('qty') != 0){
		        that.removeAttr('disabled');
	        }else if(action==='add'){
		        that.removeAttr('disabled');
	        }
          });
      }, 1000);

        //Adding a click event to the 'x' button to close immediately
        $('.alert .close').on("click", function (e) {
            $(this).parent().fadeTo(300, 0).slideUp(500);
        });
      //that.find('span.cart-action').html(new_title);
      //that.data('action', new_action);
    });
  });

});