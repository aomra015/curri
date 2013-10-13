# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#jQuery ->
  # Morris.Bar
  #   element: 'tracks_chart'
  #   data: $('#tracks_chart').data('ratings')
  #   xkey: 'checkpoint'
  #   ykeys: ['class_score']
  #   labels: ['Class Rating']
  #   postUnits: '%'

jQuery ->
  $('#track_start_date').datepicker({ dateFormat: "yy-mm-dd" })
  $('#track_start_time').timepicker()
  $('#track_end_date').datepicker({ dateFormat: "yy-mm-dd" })
  $('#track_end_time').timepicker()