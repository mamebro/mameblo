# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  voice_kitai = new Audio('/voices/kitai.wav')
  voice_wakarimasen = new Audio('/voices/wakarimasen.wav')
  $('#vote-good').click ->
    voice_kitai.play()
  $('#vote-pass').click ->
    voice_wakarimasen.play()
