$(document).ready(function() {
	$("header nav.responsive.px796over div, article aside, div.blackboard, div.blackboard p.error, div.message").hide();
	
	setInterval(function(){
	
		var mode = location.hash;
		
		if (mode == "#signup") {
			$("div#signup").fadeIn("slow");
		} else if (mode == "#signin") {
			$("div#signin").fadeIn("slow");
		} else if (mode == "#edit") {
			$("div#edit").fadeIn("slow");
		}
	
	},100);
	
	$("p.close").click(function(){
		location.hash = "";
		$("div.blackboard").fadeOut("slow");
	});
	
	$(window).keydown(function(e){
 		if (e.keyCode == "27") {
 			location.hash = "";
 			$("div.blackboard").fadeOut("slow");
 		}
	});
	
	$("input[type='text']").focus(function(){
		if($(this).val() == $(this).attr('defaultValue'))
			$(this).val('');
		}).blur(function() {
			if(jQuery.trim($(this).val()) == "") {
				$(this).val($(this).attr('defaultValue'));
		}
	});
	
	$("form#new_user").live("ajax:success", function(xhr, data, status){
		if (data.result == "success") {
			location.hash = "";
			$("div.blackboard").fadeOut("slow");
			$("div#service").slideUp("slow");
			$("div.message.success").slideDown("slow");
		}else{
			$("p.error").slideDown("fast").html("<b>Failure</b>");
		}
	});
	
	$("article").hover(
  	function () {
    	$(this).children("aside").show();
  	},
  	function () {
    	$(this).children("aside").hide();
  	}
	);
	
	$("header nav.responsive.px796over span.tool").click(function(){
		$(this).next("div").stop().fadeIn("fast");
		$(this).css({ opacity: "0.44" });
	});
	
	$("div.message a.button").click(function(){ reload(); });
});

function reload(){
	window.location.reload();
}

function test(a) {
	if(a == null){ a = "alert!" }
	window.alert(a);
}

