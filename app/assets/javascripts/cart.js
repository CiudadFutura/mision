$(document).ready(function() {
    $("#register-guest").validate({
        rules: {
            'usuarios[warehouse]': "required",
            'usuarios[email]': {
                required: true,
                email: true
            },
            'usuarios[nombre]': 'required',
            'usuarios[apellido]': 'required',
            'usuarios[dni]': 'required',
            'usuarios[calle]': 'required',
            'usuarios[cel1]': 'required',
        },
        messages: {
            'usuarios[warehouse]': "Indique donde retira",
            'usuarios[email]': {
                required: "Necesitamos su email, para contactarlo",
                email: "Su email tiene que tener la forma nombre@dominio.com"
            },
            'usuarios[nombre]': 'El Nombre es requerido',
            'usuarios[apellido]': 'El Apellido es requerido',
            'usuarios[dni]': 'El DNI es requerido',
            'usuarios[calle]': 'El Domicilio es requerido',
            'usuarios[cel1]': 'El Celular es requerido',
        },
        invalidHandler: function(event, validator) {
            // 'this' refers to the form
            var errors = validator.numberOfInvalids();
            if (errors) {
                var message = errors == 1
                    ? 'Debe completar el campo requerido'
                    : 'Complete los ' + errors + ' campos requeridos';
                $("#errorMessages span").html(message);
                $("#errorMessages").removeClass('hide');
            } else {
                $("#errorMessages").addClass('hide');
            }
        }

    });

    $("#warehouses-choose").validate({
        rules: {
            'pedidos[warehouse]': "required"
        },
        messages: {
            'pedidos[warehouse]': "Indique donde retira"
        },
        invalidHandler: function(event, validator) {
            // 'this' refers to the form
            var errors = validator.numberOfInvalids();
            if (errors) {
                var message = errors == 1
                    ? 'Debe completar el campo requerido'
                    : 'Complete los ' + errors + ' campos requeridos';
                $("#errorMessages span").html(message);
                $("#errorMessages").removeClass('hide');
            } else {
                $("#errorMessages").addClass('hide');
            }
        }

    });
})