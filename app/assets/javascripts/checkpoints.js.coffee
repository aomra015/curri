# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.checkpoint-score-links').on "click", 'input[type=submit]', (e) ->
    e.preventDefault()
    urlPath = $(this).closest('form').attr('action')
    checkpoint = $(this).closest('.row')
    current_score = urlPath.slice(-1)
    $.ajax
      url: urlPath
      type: 'POST'
      success: ->
        #update student view
        marker = checkpoint.find('.marker')
        marker.removeClass('checkpoint_0 checkpoint_1 checkpoint_2').fadeOut ->
          marker.addClass("checkpoint_#{current_score}").fadeIn()