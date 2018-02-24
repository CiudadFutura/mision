$(document).ready(function(){
    $('.carousel').carousel({
        interval: 5000
    })

    //Docs at http://www.chartjs.org
    var orders_data = {
        labels: ["Enero","Enero","Febrero","Febrero","Marzo","Marzo","Abril","Abril","Mayo","Mayo","Junio","Junio",
            "Julio","Julio","Agosto","Agosto","Septiembre","Septiembre","Octubre","Octubre","Noviembre","Noviembre","Diciembre","Diciembre"],
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
