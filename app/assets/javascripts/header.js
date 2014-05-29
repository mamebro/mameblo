$(function() {
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
        $navMenuContent = $('.nav-menu-content'),
        $nav = $navMenuContent.find('.nav'),
        animationDelay = 50,
        rotateDegree = -10,
        positionLeft = 5;
    if ($body.hasClass('is-menu')) {
      $body.removeClass('is-menu');
      $navMenuContent.hide();
    } else {
      $body.addClass('is-menu');
      $navMenuContent.show();
      $nav.each(function(index) {
        var rotateDegreeProperty = rotateDegree * (index + 1),
            positionLeftProperty = positionLeft * ((index + 1) * (index + 1));
        $(this)
          .css({
            'transform': 'rotate(' + rotateDegreeProperty + 'deg)'
          })
          .animate({
            'opacity': 0,
            'margin-top': '-10px',
            'margin-left': (positionLeftProperty - 10) + 'px'
          }, 0)
          .delay(animationDelay * index)
          .animate({
            'opacity': 1,
            'margin-top': '10px',
            'margin-left': (positionLeftProperty + 10) + 'px'
          }, 100)
          .animate({
            'opacity': 1,
            'margin-top': '0',
            'margin-left': positionLeftProperty + 'px'
          }, 100);
      });
    }
  }
});
