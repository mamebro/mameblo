$(function() {
  $('.nav-menu-control').click(function() {
    var $body = $('body'),
        $navMenuContent = $('.nav-menu-content');
    if ($body.hasClass('is-menu')) {
      $body.removeClass('is-menu');
      $navMenuContent.hide();
    } else {
      $body.addClass('is-menu');
      $navMenuContent.show();
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
