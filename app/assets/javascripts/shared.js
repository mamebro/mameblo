$(function() {
  $('.entry-beans.is_throwable').swipe( {
    swipeLeft:function(event, direction, distance, duration, fingerCount) {
      $(this).submit();
    },
    threshold: 5
  });

  $('.entry-beans.is_throwable').submit(function() {
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
    var $count = $(this).prev('.entry').find('.beans-count');
    var currentBeans = Number($count.attr('data-beans-count')) + 1;
    $count.html(currentBeans).attr('data-beans-count', currentBeans);
  });

  $('.bean').each(function () {
    $(this).addClass(setBeanType());
  });

  function setBeanType() {
    var beanTypes = ['bean-a', 'bean-b', 'bean-c', 'bean-d'];
    var rand = 0 + Math.floor(Math.random() * 4);
    return beanTypes[rand];
  }
});
