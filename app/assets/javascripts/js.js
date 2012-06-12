$(document).ready(function() {
	$("div.blackboard, div.blackboard div.step2, div.blackboard div.step3").hide();
	
	
	$("p.button.signup").click(function(){ $("div#signup").fadeIn("slow"); });
	$("p.button.signin").click(function(){ $("div#signin").fadeIn("slow"); });
	$("p.close").click(function(){ $("div.blackboard").fadeOut("slow"); });
	
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