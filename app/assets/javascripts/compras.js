// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

    setInterval(refreshPartial, 60000);

    var $loading = $('#divLoading');

    $(document).bind('ajaxStart',function(){
        $loading.show();
    }).bind('ajaxStop', function () {
        $loading.hide();
    });

    function refreshPartial(){
	    if ($('.input-large').data('compraId') != undefined) {
		    $.ajax({
			    type: 'GET',
			    url: 'refresh_status/'+ $('.input-large').data('compraId'),
			    dataType: "html",
			    success: onAddStatusSuccess
		    })
	    }
    };

    var ESTADO_COMPLETADO = 5;
    var editable_conf = {
        type: 'select',
        title: 'Seleccione el Estado',
        placement: 'top',
        emptytext : 'Sin puesto',
        success: refreshPartial,
        error: function(response, newValue) {
            if(response.status === 500) {
                return 'Servicio no disponible. Intente luego.';
            } else {
                return response.responseText;
            }
        }

    };

    $('.checkpoint').editable(editable_conf);

    $('.input-large').on('click', on_check_click);

    function on_check_click() {
        var new_value = $(this).is(':checked') ? ESTADO_COMPLETADO : '';

        add_status({
            compraId: $(this).data('compraId'),
            sectorId: $(this).data('sectorId'),
            deliveryId: $(this).data('deliveryId'),
            statusId: $(this).data('statusId'),
            new_value: new_value
        })

    };

    $('.select-statuses').on('change', on_change);

    function on_change() {
        var new_value = $(this).val();

        add_status({
            compraId: $(this).data('compraId'),
            sectorId: $(this).data('sectorId'),
            deliveryId: $(this).data('deliveryId'),
            statusId: $(this).data('statusId'),
            new_value: new_value
        });
    };

    function add_status(args) {
        $.ajax({
            type: 'GET',
            url: 'add_status/' + args.compraId,
            data: {
                id_sector: args.sectorId,
                id_delivery: args.deliveryId,
                id_status: args.statusId,
                checked: args.checked,
                new_status: args.new_value
            },
            dataType: "html",
            success: onAddStatusSuccess
        });
    }

    function onAddStatusSuccess(response) {
        $('#statuses-table').children().remove();
        $('#statuses-table').html(response);
        $('.input-large').on('click', on_check_click);
        $('.select-statuses').on('change', on_change );
        $('.checkpoint').editable(editable_conf);
    }


});
