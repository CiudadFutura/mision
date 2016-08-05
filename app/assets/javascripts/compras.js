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
})
