$ = jQuery

$ ->
  # Update Header
  HelpStatus.poll() if $('#student-help-toggle').length
  RequestNumber.poll() if $('#requesters_link').length

  # Student: Help-toggle AJAX
  $('#student-help-toggle a').on 'ajax:success', (e, data) ->
    HelpStatus.helpToggle(data)
    HelpStatus.showTooltip(data)