$(function() {
  $('.nav-editor-control').click(function() {
    var $body = $('body');
    if ($body.hasClass('is-editor')) {
      if ($('#new_entry').hasClass('submitable')) {
        if (window.confirm('投稿しなくて大丈夫？')) {
          $body.removeClass('is-editor');
        }
      } else {
        $body.removeClass('is-editor');
      }
    } else {
      $body.addClass('is-editor');
    }
  });

  $('#entry-form-content').attr('data-rows-original', $('#entry-form-content').attr('rows'));

  $('#entry-form-content').bind('keyup', function() {
	  var self = this;
	  var value = $(this).val().split('\n');
	  var value_row = 0;
	  $.each(value, function(i, val) {
	    value_row += Math.max(Math.ceil(val.length/self.cols), 1);
	  });
	  var input_row = $(this).attr('rows');
	  var original_row = $(this).attr('data-rows-original');
	  var next_row = (input_row <= value_row) ? value_row + 1 : Math.max(value_row + 1, original_row);
	  $(this).attr('rows', next_row);
    checkSubmitable();
  });

  $('.new_entry, .edit_entry').find('textarea').focus(function () {
    if (!$(this).hasClass('focus')) {
      $(this).addClass('focus');
    }
    $(window).keydown(function (e) {
      if (e.metaKey && e.keyCode === 13) {
        $('.new_entry, .edit_entry').submit();
      }
    });
    checkSubmitable();
  });

  function checkSubmitable() {
    if ($('#entry-form-content').val().replace(/\s/g, '').length > 0) {
      if (!$('#new_entry').hasClass('submitable')) {
        $('#new_entry').addClass('submitable');
        $('#entry-form-submit').fadeIn(250);
      }
    } else {
      if ($('#new_entry').hasClass('submitable')) {
        $('#new_entry').removeClass('submitable');
        $('#entry-form-submit').fadeOut(250);
      }
    }
  }
});