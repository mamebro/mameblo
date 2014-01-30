$(function() {
  setsubun();

  function setsubun() {
    $('body')
      .append('<span class="setsubun"></span>')
      .find('.setsubun:last-child')
      .animate(
        {
          right: '2000px'
        },
        1000,
        'swing'
      );;
  }
});
