@Curri.RequestsList =

  updateList: (data) ->
    if data.helpStatus == true
      @addRequest(data.requesterPartial)
    else
      @removeRequest(data.requesterId)

  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.remove() if $placeholder.length
    $('#requesters-table').append(partial)

  removeRequest: (requesterId) ->
    $("#requester#{requesterId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.requester').length
        $('#requesters-table').append('<tr id="placeholder"><td colspan="4">You have no students needing help!</td></tr>')