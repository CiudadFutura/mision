/**
 * Created by niquito on 02/08/15.
 */

$(document).ready(ajustamodal);

$(window).resize(ajustamodal);

function ajustamodal(){
	var altura = $(window).height() - 350;
	$(".activa-scroll").css({"height":altura,"overflow-y":"auto"});
};
