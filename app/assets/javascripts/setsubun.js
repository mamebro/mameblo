$(function() {
  var beanFlyingDistance, beanFlyingHeight, beanFlyingMaxHeight;

  setBeanFlyingConfig();
  setsubun();

  setInterval(function() {
    setsubun();
  }, 64);

  $(window).resize(function() {
    setBeanFlyingConfig();
  });

  window.onscroll = function() {
    setBeanFlyingConfig();
  }

  function setBeanFlyingConfig() {
    beanFlyingDistance = window.innerWidth + 18;
    beanFlyingMaxHeight = window.pageYOffset + window.innerHeight;
  }

  function setsubun() {
    beanFlyingHeight = Math.floor(Math.random() * beanFlyingMaxHeight);
    $('body')
      .append('<span class="bean bean-setsubun"></span>')
      .find('.bean-setsubun:last-child')
      .css('top', beanFlyingHeight)
      .animate(
        {
          right: beanFlyingDistance
        },
        1000,
        'linear'
      );;
  }
});
