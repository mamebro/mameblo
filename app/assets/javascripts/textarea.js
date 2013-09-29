$(function() {
  $('textarea').each(function() {
	  $(this).attr('data-rows-original', $(this).attr('rows'));
  });
  
  $('textarea').bind('keyup', function() {
	  var self = this;
	  var value = $(this).val().split("\n");
	  var value_row = 0;
	  $.each(value, function(i, val) {
	    value_row += Math.max(Math.ceil(val.length/self.cols), 1);
	  });
	  var input_row = $(this).attr('rows');
	  var original_row = $(this).attr('data-rows-original');
	  var next_row = (input_row <= value_row) ? value_row + 1 : Math.max(value_row + 1, original_row);
	  $(this).attr('rows', next_row);
  });

  $('textarea').focus(function () {
    $(this).addClass('focus');
  });

  $('#entry_form .input').focus(function () {
    $('#entry-form-submit').show();
  });
});
