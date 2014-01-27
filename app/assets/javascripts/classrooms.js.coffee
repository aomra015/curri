$ = jQuery

$ ->
  # Update Header
  HelpStatus.poll() if $('.help-toggle').length
  RequestNumberPoller.poll() if $('#requesters_link').length

  # Student: Help-toggle AJAX
  $('.help-toggle a').on 'ajax:success', (e, data) ->
    HelpStatus.helpToggle(data)
    HelpStatus.showTooltip(data)