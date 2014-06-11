$(function() {
  $('.entry-beans.is_throwable').swipe( {
    swipeLeft:function(event, direction, distance, duration, fingerCount) {
      $(this).submit();
    },
    threshold: 5
  });

  $('.entry-beans.is_throwable').click(function() {
    $(this).submit();
  });

  $('.entry-beans.is_throwable').submit(function() {
    var $count = $(this).find('.beans-count');
    var currentBeans = Number($count.attr('data-beans-count')) + 1;
    $count.html(currentBeans).attr('data-beans-count', currentBeans);
  });
});
