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
    $(this).modal(fadeDuration: 250)
    return false