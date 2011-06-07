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
	
	$('.login').click(function () {
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
		
	jQuery.validator.addMethod("noSpace", function(value, element) { 
	  return value.indexOf(" ") < 0 && value != ""; 
	}, "No space please and don't leave it empty");
	
		
  $("form.edit_user").validate({
		rules: {
			"user[login]": {required: true, remote:"/users/check_login", maxlength: 15, noSpace: true }
		},
		messages: {
      "user[login]": {
        required: "You must create a username.",
        remote: "This username has already been chosen.",
				maxlength: "Your username can't be more than 15 characters.",
				noSpace: "No spaces in usernames please."
      }
		}
	});
	
	$("#new_video").validate({
		rules: {
			"video[url]": {required: true, remote:"/videos/check_url" },
			"video[title]": { required: true }
		},
		messages: {
      "video[url]": {
        required: "You must paste a video url here.",
        remote: "This is not a valid video link."
      },
			"video[title]": {
				required: "You must write a title for this video."
			}
		}
	});
	
	$("#new_comment").validate({
		rules: {
			"comment[message]": { required: true }
		},
		messages: {
      "comment[message]": {
        required: "You must write a comment!"
      }
		}
	});
	
});