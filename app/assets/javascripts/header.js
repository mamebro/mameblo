$(function() {
  $('.nav-menu-control').click(function() {
    var $body = $('body'),
        $navMenuContent = $('.nav-menu-content'),
        $nav = $navMenuContent.find('.nav'),
        animationDelay = 50;
    if ($body.hasClass('is-menu')) {
      $body.removeClass('is-menu');
      $navMenuContent.hide();
    } else {
      $body.addClass('is-menu');
      $navMenuContent.show();
      $nav.each(function(index) {
        $(this)
          .animate({
            'opacity': 0,
            'margin-top': '20px'
          }, 0)
          .delay(animationDelay * index)
          .animate({
            'opacity': 1,
            'margin-top': '0'
          }, 100, 'swing');
      });
    }
  });

  $('.brand').click(function() {
    if (0 < window.pageYOffset) {
      $('body,html').animate({scrollTop: 0}, 250, 'swing');
    } else {
      location.href = '/';
    }
  });
});
