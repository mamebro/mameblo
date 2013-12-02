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
        $('.pager-next').removeClass('button-touched');
      }
      emojify.run();
    }
  });

  $('.button').click(function() {
    $(this).addClass('button-touched');
  });

  $('.pager-next').click(function() {
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
  
  $('#beBrother').click(function() {
    $('#beBrother').hide();
    $('#beBrotherAfter').show();
  });

  $('.bean-throw').click(function() {
    $(this).parents('.entry-beans').submit();
  });

  $('.entry-beans').swipe( {
    swipeLeft:function(event, direction, distance, duration, fingerCount) {
      $(this).submit();
    },
    threshold: 0
  });

  $('.entry-beans').submit(function() {
    $(this)
      .append('<span class="bean"></span>');
    $(this).find('.bean:last-child')
      .addClass(setBeanType())
      .animate(
        {
          'margin-left': '125px',
          'opacity': 0
        },
        0
      )
      .animate(
        {
          'margin-left': '0',
          'opacity': 1
        },
        250,
        'swing'
      );
    $count = $(this).prev('.entry').find('.beans-count');
    $count.html(Number($count.text().replace(/^\s+|\s+$/g, '')) + 1);
  });

  $('.bean').each(function () {
    $(this).addClass(setBeanType());
  });

  function setBeanType() {
    var beanTypes = ['bean-a', 'bean-b', 'bean-c', 'bean-d'];
    var rand = 0 + Math.floor(Math.random() * 4); 
    return beanTypes[rand];
  }

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
