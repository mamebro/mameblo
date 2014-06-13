$(function() {
  var touchStart, touchEnd;

  $(document.documentElement)
    .on('click', '.entry-beans.is_throwable', function(e) {
      throwOmnidirectionalBean();
      $(this).submit();
    })
    .on('submit', '.entry-beans.is_throwable', function(e) {
      var $entry = $(this).parents('.entry'),
          currentBeans = Number($entry.attr('data-beans-count')) + 1;
      $entry.attr('data-beans-count', currentBeans);
      $(this).find('.beans-count').html(currentBeans);
    })
    .on('touchstart', '.entry', function(e) {
      $(this).find('.entry-beans.is_throwable').submit();
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
  }
});
