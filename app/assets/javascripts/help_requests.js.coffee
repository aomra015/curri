@HelpRequests =
  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.remove() if $placeholder.length
    $('#requesters-table').append(partial)

  removeRequest: (requesterId) ->
    $("#requester#{requesterId}").remove()
    $('#requesters-table').append('<tr id="placeholder"><td colspan="3">You have no students needing help!</td></tr>')