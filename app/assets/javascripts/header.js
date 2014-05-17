$(function() {
  $('.nav-menu-control').click(function() {
    var $body = $('body');
    if ($body.hasClass('is-menu')) {
      $('body').removeClass('is-menu');
      $('.nav-menu-content').hide();
    } else {
      $('body').addClass('is-menu');
      $('.nav-menu-content').show();
    }
  });
});
