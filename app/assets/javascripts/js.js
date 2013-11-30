$(function() {
  $('#beBrotherAfter').hide();

  emojify.setConfig({
    emojify_tag_type: 'span',
    emoticons_enabled: false,
    people_enabled: true,
    nature_enabled: true,
    objects_enabled: true,
    places_enabled: true,
    symbols_enabled: true
  });
  emojify.run();

  $.autopager({
    content: '#content',
    autoLoad: false,
    load: function(current) {
      if ($(this).attr('data-max-page') == current.page) {
        $('.pager-next').hide();
      } else {
        $('.pager-next').removeClass('button-disabled').addClass('button-primary');
      }
      emojify.run();
    }
  });

  $('.pager-next').click(function() {
    $(this).removeClass('button-primary').addClass('button-disabled');
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
