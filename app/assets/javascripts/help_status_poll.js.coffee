@HelpStatusPoller =
  helpStatus:
    "In Help Queue": true
    "Ask for Help": false
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('.help-toggle a').attr('href')
      dataType: 'JSON'
      success: HelpStatusPoller.helpToggle

  helpToggle: (data) ->
    $helpLink = $(".help-toggle a")
    if data.help != HelpStatusPoller.helpStatus[$helpLink.text()]
      $helpLink.removeClass('in-queue ask-help')
      $helpLink.text("In Help Queue").addClass('in-queue') if data.help
      $helpLink.text("Ask for Help").addClass('ask-help') if !data.help
    HelpStatusPoller.poll()
