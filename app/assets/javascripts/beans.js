$(function() {
  $('.entry').swipe( {
    swipeLeft:function(event, direction, distance, duration, fingerCount) {
      $(this).find('.entry-beans.is_throwable').submit();
    },
    threshold: 5
  });

  $('.entry-beans.is_throwable').click(function() {
    $(this).submit();
  });

  $('.entry-beans.is_throwable').submit(function() {
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
  });
});
