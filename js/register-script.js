//-- Confirm Password in register.cfm

$(document).ready(function(){
	/*$("#email,#user").change(function(){
		let user = $(this).val();
		alert(user);
	});*/
	$("#confirmPassWord").change(function(){
		let button = $("#register").find("#submit");
		let pass = $("#register").find("#passWord");
		if(!button.hasClass("disabled"))
			button.addClass("disabled");
			if(pass.val() == $(this).val() && button.hasClass("disabled"))
				button.removeClass("disabled");
	});
});