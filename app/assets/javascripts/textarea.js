$(function() {
  $('#entry-form-title').focus();

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

  if ($('#entry-form-submit').size() > 0) {
    $(window).keydown(function (e) {
      if (e.metaKey && e.keyCode === 13) {
        $('.new_entry, .edit_entry').submit();
      }
    });
  }

  $('.new_entry, .edit_entry').submit(function () {
    var title = $('#entry-form-title').val();
    var content = $('#entry-form-content').val();
    if (!title || !content) {
      if (!title && !content) {
        $('#entry-form-title').focus();
      } else if (!title) {
        $('#entry-form-title').focus();
      } else {
        $('#entry-form-content').focus();
      }
      return false;
    }
  });

  $('.new_entry .input').focus(function () {
    $('#entry-form-submit').fadeIn(250);
  });
});
