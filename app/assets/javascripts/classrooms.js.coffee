$ = jQuery

$ ->
  # Update Header
  HelpStatusPoller.poll() if $('.help-toggle').length
  RequestNumberPoller.poll() if $('#requesters_link').length

  # Student: Help-toggle AJAX
  $('.help-toggle a').on 'ajax:success', (e, data) ->
    HelpStatusPoller.helpToggle(data)
    $('#help-tooltip').show
    $helpTooltip = $('#help-tooltip').text(data.message).show()
    hideTooltip = -> $helpTooltip.fadeOut()
    setTimeout(hideTooltip, 2000)