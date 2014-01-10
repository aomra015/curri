@RequestNumberPoller =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#requesters_link').attr('href')
      dataType: 'JSON'
      success: RequestNumberPoller.updateRequesters

  updateRequesters: (data) ->
    reqLimit = $('#requesters_link').data("reqlimit")
    newReqNum = data.requesters_numb
    rnText = $('.req-num').text() || 0
    oldReqNum = parseInt(rnText)
    oldReqNum +=  1 if rnText.toString().match(/\+/)
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