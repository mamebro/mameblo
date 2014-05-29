# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#circus-tent-close').click ->
    $('#circus-tent-close').hide();
    $('#circus-tent-left-open').show();
  $('#circus-tent-left-open').click ->
    $('#circus-tent-close').show();
    $('#circus-tent-left-open').hide();
