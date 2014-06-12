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
        currentBeans = Number($entry.attr('data-beans-count')) + 1;
    $entry.attr('data-beans-count', currentBeans);
    $(this).find('.beans-count').html(currentBeans);
  });
});
