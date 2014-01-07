@HeaderPoller =
  helpStatus:
    "I need help!": true
    "I'm OK": false
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#help-toggle').data('url')
      dataType: 'JSON'
      success: HeaderPoller.helpToggle

  helpToggle: (data) ->
    $helpLink = $("#help-toggle a")
    if data.help != HeaderPoller.helpStatus[$helpLink.text()]
      $helpLink.text("I need help!") if data.help
      $helpLink.text("I'm OK") if !data.help
    HeaderPoller.poll()
