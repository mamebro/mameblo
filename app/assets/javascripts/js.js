$(function() {
  $('#beBrotherAfter').hide();

  new WOW().init();

  $('.alert').delay(5000).queue(function() {
    $(this).addClass('flipOutX').dequeue();
  });
  $('.alert').click(function() {
    $(this).addClass('flipOutX');
  });

  $('.button').click(function() {
    $(this).addClass('button-touched');
  });

  $('.pager-next').click(function() {
    $.autopager('load');
    return false;
  });

  $('.view-phone .brand').click(function () {
    if ($('.view-phone .navs').hasClass('opened')) {
      $('.view-phone .navs').slideUp('fast').removeClass('opened');
      $('.view-phone .brand').removeClass('opened');
    } else {
      $('.view-phone .navs').slideDown('fast').addClass('opened');
      $('.view-phone .brand').addClass('opened');
    }
  });

  $('#beBrother').click(function() {
    $('#beBrother').hide();
    $('#beBrotherAfter').show();
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
});
