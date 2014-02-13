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
    $('.grid-unit').last().after($(data.partial).fadeIn('slow'))

  $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
    Curri.form_validations('classroom', JSON.parse(xhr.responseText))

  $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
    $.modal.close()
    $('.grid-unit').last().after($(data.partial).fadeIn('slow'))

  $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
    Curri.form_validations('teacher', {token: xhr.responseText})

