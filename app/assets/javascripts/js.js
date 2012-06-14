$(document).ready(function() {
	$("article aside, div.blackboard, div.blackboard p.error, div.message").hide();
	
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
	
	$("div#signup input[type='text']").focus(function(){
		
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
    	$(this).children("aside").stop().fadeIn("fast");
  	},
  	function () {
    	$(this).children("aside").fadeOut(100);
  	}
	);
	
	$("div.message a.button").click(function(){ reload(); });
});

function reload(){
	window.location.reload();
}

function test(a) {
	if(a == null){ a = "alert!" }
	window.alert(a);
}

