$(document).ready(function() {
  $('textarea').each(function(){
	$(this)
	    .css({
		'overflow':'hidden',
		'resize':'none'
	    })
	    .data('original_row',$(this).attr('rows'));
    });
    $('textarea').bind('keyup',function(){
	var self = this;
	var value = $(this).val().split("\n");
	var value_row = 0;
	$.each(value,function(i,val){
	    value_row += Math.max(Math.ceil(val.length/self.cols),1);
	});
	console.log(value_row);
	var input_row = $(this).attr('rows');
	var original_row = $(this).data('original_row');
	var next_row = (input_row <= value_row) ? value_row+1 : Math.max(value_row+1,original_row);
	$(this).attr('rows',next_row);
    });
});

function test(a) {
  if(a == null){ a = "alert!" }
  window.alert(a);
}