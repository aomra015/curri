@Curri ?= {}

@Curri.supports_html5_storage = ->
  try
    return "localStorage" of window and window["localStorage"] isnt null
  catch e
    return false

@Curri.largeScreen = ->
  return window.matchMedia("(min-width: 1024px)").matches

@Curri.mobileScreen = ->
  return window.matchMedia("(max-width: 480px)").matches

@Curri.form_validations = (resource, errors) ->
  $('.error-message').remove()
  for field, error of errors
    $input = $("##{resource}_#{field}")
    $error = $('<span>').addClass('error-message').text(error)
    $input.addClass('error').before($error)

@Curri.clear_modal = ->
  $modal = $('.modal')
  $modal.find('input[type="text"]').each ->
    $(this).val('')
  $modal.find('textarea').each ->
    $(this).val('')
  $.modal.close()