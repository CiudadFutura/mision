//custom.js

$(document).ready(function() {
    /*
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

    */

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
    $(".card").hover(
        function() {
            var cardId = "#" + this.id;
            $(cardId).toggleClass("shadow");
        }
    )
});