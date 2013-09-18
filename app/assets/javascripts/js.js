$(document).ready(function() {
  $('#beBrotherAfter').hide();
  $('#unBrotherAfter').hide();

  $.autopager({
    content: '#content',
    autoLoad: false
  });

  $('.pager-next').click(function() {
    $(this).hide();
    $.autopager('load');
    return false;
  });
  
  $('#brand').click(function () {
	  if ($('#navs').hasClass('opened')) {
	    $('#navs').slideUp('fast').removeClass('opened');
      $('#brand').removeClass('opened');
	  } else {
		  $('#navs').slideDown('fast').addClass('opened');
      $('#brand').addClass('opened');
	  }
  });
  
  $('#beBrother').click(function(){
    $('#beBrother').hide();
    $('#beBrotherAfter').show();
  });
  
  $('#unBrother').click(function(){
    $('#unBrother').hide();
    $('#unBrotherAfter').show();
  });

  // vote
  var voice_kitai = new Audio('/voices/kitai.wav');
  var voice_wakarimasen = new Audio('/voices/wakarimasen.wav');
  $('#vote-good').click( function () {
    voice_kitai.play();
  });
  $('#vote-pass').click( function () {
    voice_wakarimasen.play();
  });
  
  // anchor
  $("a[href*=#]").click(function(){
		if(location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname){
			var $target = $(this.hash);
			$target = $target.length && $target || $("[name=' + this.hash.slice(1) +']");
			if($target.length){
				var targetOffset = $target.offset().top;
				$("html,body").animate({scrollTop: targetOffset}, 500);
				return false;
			}
		}
	});
  
  // textarea resize
  $('textarea').each(function(){
	  $(this).css({'overflow': 'hidden', 'resize':'none'}).data('original_row',$(this).attr('rows'));
  });
  
  $('textarea').bind('keyup',function(){
	  var self = this;
	  var value = $(this).val().split("\n");
	  var value_row = 0;
	  $.each(value,function(i,val){
	    value_row += Math.max(Math.ceil(val.length/self.cols),1);
	  });
	  var input_row = $(this).attr('rows');
	  var original_row = $(this).data('original_row');
	  var next_row = (input_row <= value_row) ? value_row+1 : Math.max(value_row+1,original_row);
	  $(this).attr('rows',next_row);
  });

  $('textarea').focus(function () {
    $(this).addClass('focus');
  });

  $('#entry_form .input').focus(function () {
    $('#entry-form-submit').show();
  });
});
