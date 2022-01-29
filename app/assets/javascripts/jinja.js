window.addEventListener('DOMContentLoaded', (event) => {
  $('#circus-tent-close').click(function() {
    $('#circus-tent-close').hide();
    $('#circus-tent-left-open').show();
    return new Audio('/voices/song.wav').play();
  });
  return $('#circus-tent-left-open').click(function() {
    $('#circus-tent-close').show();
    return $('#circus-tent-left-open').hide();
  });
});
