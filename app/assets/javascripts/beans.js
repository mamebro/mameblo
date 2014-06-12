$(function() {
  var gestureModeSwitch = 0;

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
      console.log('# touchstart');
      console.log('##### touchstart-x: ' + e.originalEvent.touches[0].pageX);
      console.log('##### touchstart-y: ' + e.originalEvent.touches[0].pageY);
    })
    .on('touchmove', '.entry', function(e) {
      console.log('# touchmove');
      console.log('##### touchmove-x: ' + e.originalEvent.touches[0].pageX);
      console.log('##### touchmove-y: ' + e.originalEvent.touches[0].pageY);
    })
    .on('touchend', '.entry', function(e) {
      console.log('# touchend');
    });
});
