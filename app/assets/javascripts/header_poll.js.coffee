@HelpStatusPoller =
  helpStatus:
    "In queue": true
    "Not in queue": false
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#help-toggle a').attr('href')
      dataType: 'JSON'
      success: HelpStatusPoller.helpToggle

  helpToggle: (data) ->
    $helpLink = $("#help-toggle a")
    if data.help != HelpStatusPoller.helpStatus[$helpLink.text()]
      $helpLink.text("In queue") if data.help
      $helpLink.text("Not in queue") if !data.help
    HelpStatusPoller.poll()
