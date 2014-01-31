$ = jQuery

$ ->
  if $('#requesters-table').length
    # Remove student from help queue
    $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
      Curri.RequestsList.removeRequest(data.id)