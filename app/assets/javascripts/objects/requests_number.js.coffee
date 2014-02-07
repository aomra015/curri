@Curri.RequestsNumber =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#requesters_link').attr('href')
      dataType: 'JSON'
      success: Curri.RequestsNumber.updateRequesters

  updateRequesters: (data) ->
    $requestsLink = $('#requesters_link')
    reqLimit = $requestsLink.data("reqlimit")
    oldReqNum = $requestsLink.data("requests")
    newReqNum = JSON.parse(data.requesters).length

    if newReqNum != oldReqNum
      # Reset title
      document.title = document.title.replace(/\(\d+\)\s/, '')

      # Update the data for next poll
      $requestsLink.data("requests", newReqNum)

      # Update the visual
      if newReqNum > 0
        $('.nav-help').toggleClass('active', true)
        $reqNumb = $('.req-num').show()
        document.title = "(#{newReqNum}) #{document.title}"
        if newReqNum <= reqLimit
          $reqNumb.text(newReqNum)
        else
          $reqNumb.text(reqLimit + "+")
      else
        $('.req-num').hide()
        $('.nav-help').removeClass('active')

    Curri.RequestsNumber.poll()