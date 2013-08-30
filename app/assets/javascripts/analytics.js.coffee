# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require private_pub

$ ->
  PrivatePub.subscribe "/track/#{TRACK_ID}/ratings", ({checkpoint, ratings}) ->
    $("#checkpoint#{checkpoint}").find('.count-number').html(ratings.length)