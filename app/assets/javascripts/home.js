$(document).ready(function(){
    $('.carousel').carousel({
        interval: 5000
    })
	var start_date = $('#ciclos').data('start-date')

	$('#calendar').fullCalendar({

		editable: false,
		monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
		monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
		dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
		dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],

		buttonText: {
			today: 'Hoy',
			month: 'month',
			week: 'week',
			day: 'day'
		},
		header: {
			left: '',
			center: 'title',
			right: ''
		},

		allDaySlot: false,
		height: 500,


		eventSources:[{
			url: '/home.json',
			editable: false
		}],

	});
	$('#calendar').fullCalendar('gotoDate', moment(start_date))

})
