$(function() {
  var beanFlyingDistance, beanFlyingHeight, beanFlyingMaxHeight;

  setBeanFlyingConfig();
  setsubun();

  setInterval(function() {
    setsubun();
  }, 500);

  $(window).resize(function() {
    setBeanFlyingConfig();
  });

  function setBeanFlyingConfig() {
    beanFlyingDistance = window.innerWidth + 18;
    beanFlyingMaxHeight = window.innerHeight;
  }

  function setsubun() {
    beanFlyingHeight = Math.floor(Math.random() * beanFlyingMaxHeight);
    $('body')
      .append('<span class="setsubun"></span>')
      .find('.setsubun:last-child')
      .css('top', beanFlyingHeight)
      .animate(
        {
          right: beanFlyingDistance
        },
        1000,
        'swing'
      );;
  }
});
