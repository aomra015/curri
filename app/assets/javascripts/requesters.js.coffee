$ = jQuery

$ ->
  # Remove student from help queue
  $('#requesters-table').on "ajax:success", '.btn-small', (e, data) ->
    HelpRequests.removeRequest(data.id)
    # SegmentIO event
    analytics.track "Teacher Answered Student"