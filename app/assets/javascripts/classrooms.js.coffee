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

  $('.progress-bar div').tooltip()