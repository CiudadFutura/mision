$(document).ready(function() {
    $('#new_compra').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $('#edit_compra').validate({
        errorPlacement: function (label, element) {
            label.addClass('error');
            label.insertBefore(element);
        },
        wrapper: 'div'

    });

    $("[id*='compra_tipo_']").on('click', function () {
        var valor = $( this ).val();
        showHideCirculos(valor);
    });

})

function showHideCirculos(valor){
    if (valor != 'circles' && valor != 'distrito') {
        $('#content-circulos').addClass('hide');
        $('#content-warehouses').addClass('hide');
    }else if(valor == 'distrito'){
        $('#content-warehouses').removeClass('hide')
        $('#content-circulos').addClass('hide');
    }else{
        $('#content-circulos').removeClass('hide');
        $('#content-warehouses').removeClass('hide')
    }
};

