# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.checkpoint-score-links').on "click", 'input[type=submit]', (e) ->
    e.preventDefault()
    urlPath = $(this).closest('form').attr('action')
    $.ajax
      url: urlPath
      type: 'POST'
      dataType: 'JSON'
      success: (data) ->
        marker = $("#checkpoint#{data.checkpoint_id}").find('.marker')
        marker.removeClass('checkpoint_0 checkpoint_1 checkpoint_2').fadeOut ->
          marker.addClass("checkpoint_#{data.current_score}").fadeIn()