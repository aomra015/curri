@RequestsList =
  addRequest: (partial) ->
    $placeholder = $('#placeholder')
    $placeholder.remove() if $placeholder.length
    $('#requesters-table').append(partial)

  removeRequest: (requesterId) ->
    $("#requester#{requesterId}").fadeOut 'slow', ->
      $(this).remove()
      unless $('.requester').length
        $('#requesters-table').append('<tr id="placeholder"><td colspan="3">You have no students needing help!</td></tr>')