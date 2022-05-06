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
//= require bootstrap-sprockets
//= require gmaps/google
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require moment
//= require fullcalendar
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.validate.localization/messages_es
//= require jquery-ui/widgets/autocomplete
//= require jquery.flexslider-min
//= require autocomplete-rails


$(document).ready(function() {
    $("#js-navbar-button").click(function() {
        $("#js-menu").toggle("slow")
    })

    $('.flexslider').flexslider({
        animation: "slide",
        start: function(slider){
            $('body').removeClass('loading');
        }
    });

    $(".scroll").click(function(event){
        event.preventDefault();
        $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
    });

/*     var navoffeset=$(".agileits_header").offset().top;
    $(window).scroll(function(){
        var scrollpos=$(window).scrollTop();
        if(scrollpos >=navoffeset){
            $(".agileits_header").addClass("fixed");
            $(".logo_products").css('padding-top', '3.5em')
        }else{
            $(".agileits_header").removeClass("fixed");
        }
    }); */
/* 
    $('#categoria-toggle').hover(
        function() {
            $(".categorias").css("display","flex")
        },
        function(event) {
            console.log(event.toElement)
            $(".categorias").hide("slow")
        }
    )
    $('.categoria').hover(
        function() {
            $(".categorias").css("display","flex")
        },
        function() {
            $(".categorias").hide("slow")
        }
    ) */
/*     $('#categoria-toggle').hover(
        function() {
            $(".categorias").css("display","flex")
        },
        function() {
            $(".categorias").hide()
        }
    ) */
    $(window).refer
    var compra_data = {};
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
    var url = '/cart/' + action + '/' + productId;
    var new_class = '';
    var old_class = '';
    var message_box = '';

    var qtySelect = $('#qty-selected-'+productId);
    var qty = qtySelect.val();
    var buttonIcon = that.children().eq(0);
    if (action === 'add') {
      //Add a new item to cart
      qtySelect.attr('disabled','disabled');
      buttonIcon.removeClass('fa fa-shopping-cart');
      buttonIcon.addClass('fa fa-remove');
      new_action = 'remove';
      new_title = "Eliminar ";
	    new_class = 'btn-danger';
	    old_class = 'btn-success';
    } else if (action === 'remove') {
      //Remove item from cart
      qtySelect.removeAttr('disabled');
      buttonIcon.removeClass('fa fa-remove');
      buttonIcon.addClass('fa fa-shopping-cart');
      new_action = 'add';
      new_title = "Agregar";
      that.parents("tr.cart-item").remove();
	    new_class = 'btn-success';
	    old_class = 'btn-danger';
    }

    $.ajax({
      url: url,
      data: { cantidad: qty },
      type: 'put'
    }).done(function (data) {
      //Update menu
      compra_data = data
      $('.cart-cantidad').html(data.cantidad);
      $('.cart-ahorro').html(data.ahorro.toFixed(2) + "%");
      $('.cart-total').html(data.total);
      $('.carrito-badge#cant').text(data.cantidad.split(' ')[0])
      $('.carrito-badge#ahorro').text(data.ahorro.toFixed(2) + "%")
      $('.carrito-badge#total').text(data.total)

      that.find('span.cart-action').html(new_title);
      that.data('action', new_action);
	    that.removeClass(old_class);
	    that.addClass(new_class);
            if (action ==='add'){
                $('#js-message-success').slideDown("fast").find('#js-message-product').html(that.prev('select.cantidad').val());
            }else{
                $('#js-message-delete').slideDown();
            }

	    addToCartTimeout = setTimeout(function () {
		    if (action ==='add'){
		      $('#js-message-success').slideUp("fast");
		    }else{
			    $('#js-message-delete').slideUp("fast");
		    }
	    }, 3000);
    });
  });

  $(".dropdown").hover(
      function() {
          $('.dropdown-menu', this).stop( true, true ).slideDown("fast");
          $(this).toggleClass('open');
      },
      function() {
          $('.dropdown-menu', this).stop( true, true ).slideUp("fast");
          $(this).toggleClass('open');
      }
  );
  $(".carrito").hover(
      () => {
          if (compra_data.total !== "$0,00" && compra_data.total !== undefined) {
            $(".aditional_data").fadeIn(500).css("display","flex")
          }
      },
      () => {
          $(".aditional_data").fadeOut(500)
      }
  )
});
