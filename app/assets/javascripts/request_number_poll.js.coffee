@RequestNumberPoller =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#requesters_link').attr('href')
      dataType: 'JSON'
      success: RequestNumberPoller.updateRequesters

  updateRequesters: (data) ->
    $requestsLink = $('#requesters_link')
    reqLimit = $requestsLink.data("reqlimit")
    oldReqNum = $requestsLink.data("requests")
    newReqNum = data.requesters_numb

    if newReqNum != oldReqNum
      # Update the data for next poll
      $requestsLink.data("requests", newReqNum)

      # Update the visual
      if newReqNum > 0
        $('.nav-help').toggleClass('active', true)
        $reqNumb = $('.req-num').show()
        if newReqNum <= reqLimit
          $reqNumb.text(newReqNum)
        else
          $reqNumb.text(reqLimit + "+")
      else
        $('.req-num').hide()
        $('.nav-help').removeClass('active')

    RequestNumberPoller.poll()