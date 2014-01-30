$(function() {
  var beanFlyingDistance;

  setBeanFlyingDistance();
  setsubun();

  $(window).resize(function() {
    setBeanFlyingDistance();
  });

  function setBeanFlyingDistance() {
    beanFlyingDistance = window.innerWidth + 18;
  }

  function setsubun() {
    $('body')
      .append('<span class="setsubun"></span>')
      .find('.setsubun:last-child')
      .animate(
        {
          right: beanFlyingDistance
        },
        1000,
        'swing'
      );;
  }
});
