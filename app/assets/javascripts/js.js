$(document).ready(function() {
	$("div.blackboard, div.blackboard div.step2, div.blackboard div.step3").hide();
	
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
	
	$("img.close").click(function(){
		$("div.blackboard").fadeOut("slow");
		location.hash = "";
	});
	
	$("p.button.next").click(function(){
		$(this).parent("div").fadeOut(200);
		$(this).parent("div").next("div").delay(300).fadeIn(1000);
	});
	
	$("div.blackboard input[type='text']").focus(function(){
		
	});
});

/*
$(this).click(function(){});
$("nav#global ul li").live("hover", function(){});
*/

function test(a) {
	if(a == null){ a = "alert!" }
	window.alert(a);
}