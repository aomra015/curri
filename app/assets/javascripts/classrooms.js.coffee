$ = jQuery

$ ->
  # Update Header
  if $('#student-help-toggle').length
    Curri.HelpStatus.poll()
    $('#student-help-toggle a').on 'ajax:success', (e, data) ->
      Curri.HelpStatus.helpToggle(data)
      Curri.HelpStatus.showTooltip(data)

  if $('#requesters_link').length
    Curri.RequestsNumber.poll()

  $('a.open-modal').click ->
    $('input[type="text"]').each ->
      $(this).val('')
    $(this).modal(fadeDuration: 250)
    return false

  $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
    $.modal.close()
    $('.grid-unit').last().after(data.partial)

  $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
    append_error_message('classroom', JSON.parse(xhr.responseText))

  append_error_message = (resource, errors) ->
    for field, error of errors
      $input = $("##{resource}_#{field}").addClass('error')
      $input.before(error)
      console.log($input)