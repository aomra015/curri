@RequestNumberPoller =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.ajax
      url: $('#requesters_link').attr('href')
      dataType: 'JSON'
      success: RequestNumberPoller.updateRequesters

  updateRequesters: (data) ->
    if $('.req-num').length
      oldNumb = parseInt($('.req-num').text())
    else
      oldNumb = 0

    if data.requesters_numb != oldNumb
      if oldNumb == 0
        $('.nav-help').after($('<div class="req-num">'))
      if 30 >= data.requesters_numb > 0
        $('.req-num').text(data.requesters_numb)
        $('.nav-help').toggleClass('active', true)
      else if data.requesters_numb > 30
        $('.req-num').text("30+")
        $('.nav-help').toggleClass('active', true)
      else
        $('.req-num').remove()
        $('.nav-help').removeClass('active')
    RequestNumberPoller.poll()