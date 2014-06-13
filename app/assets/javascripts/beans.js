$(function() {
  var touchStartX, touchStartY, touchEndX, touchEndY;

  $(document.documentElement)
    .on('click', '.entry-beans.is_throwable', function(e) {
      throwOmnidirectionalBean();
      $(this).submit();
    })
    .on('touchstart', '.entry', function(e) {
      touchStartX = e.originalEvent.touches[0].pageX;
      touchStartY = e.originalEvent.touches[0].pageY;
    })
    .on('touchmove', '.entry', function(e) {
      touchEndX = e.originalEvent.touches[0].pageX;
      touchEndY = e.originalEvent.touches[0].pageY;
    })
    .on('touchend', '.entry', function(e) {
      var touchDistanceX = touchStartX - touchEndX,
          touchDistanceY = touchEndY - touchStartY;
      if (100 < touchDistanceX && -30 < touchDistanceY && touchDistanceY < 30) {
        throwUnidirectionalBean();
        $(this).find('.entry-beans.is_throwable').submit();
      }
    })
    .on('submit', '.entry-beans.is_throwable', function(e) {
      var $entry = $(this).parents('.entry'),
          currentBeans = Number($entry.attr('data-beans-count')) + 1;
      $entry.attr('data-beans-count', currentBeans);
      $(this).find('.beans-count').html(currentBeans);
    });

  function throwOmnidirectionalBean() {
    // 無指向性の豆
    var beanFlyingDistance = window.innerWidth,
        beanFlyingScope = {
          'start' : window.pageYOffset,
          'end'   : window.pageYOffset + window.innerHeight
        },
        beanFlyingPosition = beanFlyingScope['start'] + Math.floor(Math.random() * (beanFlyingScope['end'] - beanFlyingScope['start']));
    $('body')
      .append('<span class="bean" />')
      .find('.bean:last-child')
      .css('top', beanFlyingPosition)
      .animate(
        {
          right: beanFlyingDistance
        },
        500,
        'linear'
      );
  }

  function throwUnidirectionalBean() {
    // 指向性のある豆
    var beanFlyingDistance = window.innerWidth;
    $('body')
      .append('<span class="bean" />')
      .find('.bean:last-child')
      .css('top', touchEndY)
      .animate(
        {
          right: beanFlyingDistance
        },
        500,
        'linear'
      );
  }
});