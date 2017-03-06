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
	$('#calendar').fullCalendar('gotoDate', moment(start_date));

	if(localStorage.getItem('popState') != 'shown'){
		$('#mai-escuela').modal('show');
		//$("#mai-escuela").delay(2000).fadeIn();
		localStorage.setItem('popState','shown')
	}

	$('#popup-close, #popup').click(function(e) // You are clicking the close button
	{
		$('#mai-escuela').fadeOut(); // Now the pop up is hiden.
	});

	$('.navbar-nav [data-toggle="tooltip"]').tooltip();
	$('.navbar-twitch-toggle').on('click', function(event) {
		event.preventDefault();
		$('.navbar-twitch').toggleClass('open');
	});

	$('.nav-style-toggle').on('click', function(event) {
		event.preventDefault();
		var $current = $('.nav-style-toggle.disabled');
		$(this).addClass('disabled');
		$current.removeClass('disabled');
		$('.navbar-twitch').removeClass('navbar-'+$current.data('type'));
		$('.navbar-twitch').addClass('navbar-'+$(this).data('type'));
	});

})
