// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    //make status editable
    $('.status').editable({
        type: 'select',
        title: 'Seleccione el Estado',
        placement: 'top',
        source: [
            {value: '', text: 'Incompleto'},
            {value: 1, text: 'Agendado'},
            {value: 2, text: 'En espera'},
            {value: 3, text: 'Asignado'},
            {value: 4, text: 'Entregado'},
            {value: 5, text: 'Completo'}
        ],
        emptytext : 'Incompleto',
        error: function(response, newValue) {
            if(response.status === 500) {
                return 'Servicio no disponible. Intente luego.';
            } else {
                return response.responseText;
            }
        }
    });
    $('.checkpoint').editable({
        type: 'select',
        title: 'Seleccione el Estado',
        placement: 'top',
        emptytext : 'alg',
        error: function(response, newValue) {
            if(response.status === 500) {
                return 'Servicio no disponible. Intente luego.';
            } else {
                return response.responseText;
            }
        }

    });
    $('.input-large').click(function() {
        var checked = ($(this).is(':checked'));
        var new_value = $(this).is(':checked') ? 5 : '';
        $.ajax({
            type: 'GET',
            url: 'add_status/'+ $(this).data('compraId'),
            data: {
                id_sector: $(this).data('sectorId'),
                id_delivery : $(this).data('deliveryId'),
                id_status : $(this).data('statusId'),
                checked: checked,
                new_status: new_value
            },
            dataType: "html"
        });
    });
    $('.select-statuses').change(function() {
        var checked = 'combo'
        var new_value = $(this).val()
        $.ajax({
            type: 'GET',
            url: 'add_status/'+ $(this).data('compraId'),
            data: {
                id_sector: $(this).data('sectorId'),
                id_delivery : $(this).data('deliveryId'),
                id_status : $(this).data('statusId'),
                checked: checked,
                new_status: new_value
            },
            dataType: "html"
        });
    });
});

