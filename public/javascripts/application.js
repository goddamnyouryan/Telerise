$(document).ready(function() {
	$('header nav#user h2').hover(function () {
		if ($("header nav ul").is(":hidden")) {
			$("header nav ul").slideDown("fast");
		} 
	});
	
	$('h2#new-video').click(function () {
		if ($("div#new-video").is(":hidden")) {
			$("div#new-video").slideDown("fast");
		} else {
			$("div#new-video").slideUp("fast");
		}
		return false;
	});
	
	$('h2#login').click(function () {
		if ($("div#login").is(":hidden")) {
			$("div#login").slideDown("fast");
		} else {
			$("div#login").slideUp("fast");
		}
		return false;
	});
	
	
	if ($(".flash").length > 0) {
	  	$('.flash').delay(2000).slideUp('fast');
		}
});