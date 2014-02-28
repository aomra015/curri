@Curri.HelpStatus =
  status:
    "In Help Queue": true
    "Ask for Help": false

  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('.help-toggle a').attr('href')
      dataType: 'JSON'
      success: (data) ->
        Curri.HelpStatus.helpToggle(data)
        Curri.HelpStatus.poll()

  helpToggle: (data) ->
    $helpLink = $(".help-toggle .help-btn")
    if data.help != Curri.HelpStatus.status[$helpLink.text()]
      $helpLink.removeClass('in-queue ask-help')
      if data.help
        $helpLink.text("In Help Queue").addClass('in-queue')
        analytics.track "Student Asked for Help", classroom_id: data.classroom_id
      else
        $helpLink.text("Ask for Help").addClass('ask-help')

  showTooltip: (data) ->
    $('#help-tooltip').text(data.message).show()
    setTimeout(Curri.HelpStatus.hideTooltip, 2000)

  hideTooltip: ->
    $('#help-tooltip').fadeOut()