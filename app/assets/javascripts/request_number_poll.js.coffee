@RequestNumberPoller =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#requesters_link').attr('href')
      dataType: 'JSON'
      success: RequestNumberPoller.updateRequesters

  updateRequesters: (data) ->
    reqLimit = $('.nav-help').data("reqlimit")
    rnText = $('.req-num').text()
    newReqNum = data.requesters_numb
    oldReqNum = parseInt(rnText) + rnText.toString().indexOf("+") - reqLimit.toString().length + 1 || 0
    if newReqNum != oldReqNum
      if oldReqNum == 0
        $('.nav-help').after($('<div class="req-num">'))
      if newReqNum > 0
        $('.nav-help').toggleClass('active', true)
        if newReqNum <= reqLimit
          $('.req-num').text(newReqNum)
        else
          $('.req-num').text(reqLimit + "+")
      else
        $('.req-num').remove()
        $('.nav-help').removeClass('active')
    RequestNumberPoller.poll()