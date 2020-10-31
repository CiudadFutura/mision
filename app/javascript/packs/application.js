/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require('bootstrap')
require('jquery-validation')
require('flexslider/jquery.flexslider')

import 'core-js/stable'
import 'regenerator-runtime/runtime'
import '../stylesheets/application.scss'
import '@fortawesome/fontawesome-free/js/all'
import '../src/admin_home'
import '../src/admin'


// JavaScript
let webpackContext = require.context('../src', true, /\.js$/)
for(let key of webpackContext.keys()) { webpackContext(key) }

// Images
require.context('../images', true, /\.(?:png|jpg|gif|ico|svg)$/)

// Stylesheets
require.context('../stylesheets', true, /\.sass$/)


$(document).ready(function() {

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

    var navoffeset=$(".agileits_header").offset().top;
    $(window).scroll(function(){
        var scrollpos=$(window).scrollTop();
        if(scrollpos >=navoffeset){
            $(".agileits_header").addClass("fixed");
            $(".logo_products").css('padding-top', '3.5em')
        }else{
            $(".agileits_header").removeClass("fixed");
        }
    });

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
});

