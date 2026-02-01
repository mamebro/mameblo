window.addEventListener('DOMContentLoaded', (event) => {
  $('.nav-menu-control').click(function() {
    controlMenu();
  });

  $('.brand').click(function() {
    if (0 < window.pageYOffset) {
      $('body,html').animate({scrollTop: 0}, 250, 'swing');
    } else if (window.innerWidth < 960) {
      // スマホ表示のときはメニューを開閉する
      controlMenu();
    } else {
      // PC 表示のときはトップページへ遷移する
      location.href = '/';
    }
  });

  function controlMenu() {
    var $body = $('body'),
        $navMenuContent = $('.nav-menu-content');
    if ($body.hasClass('is-menu')) {
      $body.removeClass('is-menu');
      $navMenuContent.removeClass('nav-menu-content-opened');
    } else {
      $body.addClass('is-menu');
      $navMenuContent.addClass('nav-menu-content-opened');
    }
  }
});
