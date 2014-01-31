$ = jQuery

$ ->
  # Remove student from help queue
  if $('#requesters-table').length
    $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
      Curri.RequestsList.removeRequest(data.id)