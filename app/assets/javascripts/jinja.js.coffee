$ ->
  $('#circus-tent-close').click ->
    $('#circus-tent-close').hide();
    $('#circus-tent-left-open').show();
    new Audio('/voices/song.wav').play();
  $('#circus-tent-left-open').click ->
    $('#circus-tent-close').show();
    $('#circus-tent-left-open').hide();
