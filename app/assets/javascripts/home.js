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
    var pie_data = [
        {
            value: 300,
            color:"#4DAF7C",
            highlight: "#55BC75",
            label: "Video"
        },
        {
            value: 50,
            color: "#EAC85D",
            highlight: "#f9d463",
            label: "Audio"
        },
        {
            value: 100,
            color: "#E25331",
            highlight: "#f45e3d",
            label: "Photos"
        },
        {
            value: 35,
            color: "#F4EDE7",
            highlight: "#e0dcd9",
            label: "Remaining"
        }
    ]

    var line_data = {
        labels: ["10:00am", "10:05am", "10:10am", "10:15am", "10:20am", "10:25am", "10:30am", "10:35am", "10:40am", "10:45am", "10:50am", "10:55am", "11:00am", "11:05am"],
        datasets: [
            {
                label: "My Second dataset",
                fillColor: "rgba(77, 175, 124,1)",
                strokeColor: "rgba(255,255,255,1)",
                pointColor: "rgba(255,255,255,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(151,187,205,1)",
                data: [107.18, 107.13, 107.00, 106.89, 106.91, 107.12, 107.06, 107.04, 107.10, 107.14, 107.16, 107.20, 107.21, 107.26]
            }
        ]
    };

    console.log(datasets);

    var line_data = {
        labels: ["Enero","Enero","Febrero","Febrero","Marzo","Marzo","Abril","Abril","Mayo","Mayo","Junio","Junio",
            "Julio","Julio","Agosto","Agosto","Septiembre","Septiembre","Octubre","Octubre","Noviembre","Noviembre","Diciembre","Diciembre"],
        datasets: datasets

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
