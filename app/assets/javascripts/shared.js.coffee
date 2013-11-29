# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  CLASSROOM_ID = $('#track_link').data('classroomid')
  PrivatePub.subscribe "/classrooms/#{CLASSROOM_ID}/requesters", ({requester, requesters_count}) ->
    $('#requesters_link').text("Requesters (#{requesters_count})")
    $("#help_link#{requester}").text("I'm OK")