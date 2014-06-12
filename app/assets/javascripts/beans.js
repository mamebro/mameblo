$(function() {
  var touchStart, touchEnd;

  $(document.documentElement)
    .on('click', '.entry-beans.is_throwable', function(e) {
      $(this).submit();
    })
    .on('submit', '.entry-beans.is_throwable', function(e) {
      var $entry = $(this).parents('.entry'),
          currentBeans = Number($entry.attr('data-beans-count')) + 1,
          beanFlyingDistance = window.innerWidth,
          beanFlyingScope = {
            'start' : window.pageYOffset,
            'end'   : window.pageYOffset + window.innerHeight
          },
          beanFlyingPosition = beanFlyingScope['start'] + Math.floor(Math.random() * (beanFlyingScope['end'] - beanFlyingScope['start']));
      $entry.attr('data-beans-count', currentBeans);
      $(this).find('.beans-count').html(currentBeans);
      $('body')
        .append('<span class="bean" />')
        .find('.bean:last-child')
        .css('top', beanFlyingPosition)
        .animate(
          {
            right: beanFlyingDistance
          },
          1000,
          'linear'
        );
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
      if (10 < touchDistanceX && touchDistanceY < 10) {
        $(this).find('.entry-beans.is_throwable').submit();
      }
    });
});
