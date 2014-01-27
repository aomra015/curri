$ = jQuery

$ ->
  # Remove student from help queue
  $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
    RequestsList.removeRequest(data.id)
    # SegmentIO event
    analytics.track "Teacher Answered Student"