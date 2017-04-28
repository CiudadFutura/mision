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



    //Docs at http://www.chartjs.org
    var orders_data = {
        labels: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
        datasets: orders_by_months

    };

    var ctx1 = $("#myOrdersChart");
    var myLineChart = new Chart(ctx1, {
        type: "bar",
        data: orders_data,
        options: {
            responsive:true,
            scaleShowGridLines : false,
            scaleShowLabels: false,
            showScale: false,
            pointDot : true,
            bezierCurveTension : 0.2,
            pointDotStrokeWidth : 1,
            pointHitDetectionRadius : 5,
            datasetStroke : false,
            tooltipTemplate: "<%= value %><%if (label){%> - <%=label%><%}%>"
        },

    });

    var chart_data = {
        labels: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
        datasets: users_by_months

    };

    var ctx = $("#myChart");
    var myLineChart = new Chart(ctx, {
        type: "bar",
        data: chart_data,
        options: {
            responsive:true,
            scaleShowGridLines : false,
            scaleShowLabels: false,
            showScale: false,
            pointDot : true,
            bezierCurveTension : 0.2,
            pointDotStrokeWidth : 1,
            pointHitDetectionRadius : 5,
            datasetStroke : false,
            tooltipTemplate: "<%= value %><%if (label){%> - <%=label%><%}%>"
        },

    });

    var line_data = {
        labels: ["Enero","Enero","Febrero","Febrero","Marzo","Marzo","Abril","Abril","Mayo","Mayo","Junio","Junio",
            "Julio","Julio","Agosto","Agosto","Septiembre","Septiembre","Octubre","Octubre","Noviembre","Noviembre","Diciembre","Diciembre"],
        datasets: products_by_cycles

    };

    var ctx2 = $("#myLineChart");
    var myLineChart = new Chart(ctx2, {
        type: "line",
        data: line_data,
        options: {
            responsive:true,
            scaleShowGridLines : false,
            scaleShowLabels: false,
            showScale: false,
            pointDot : true,
            bezierCurveTension : 0.2,
            pointDotStrokeWidth : 1,
            pointHitDetectionRadius : 5,
            datasetStroke : false,
            tooltipTemplate: "<%= value %><%if (label){%> - <%=label%><%}%>"
        },

    });

})
