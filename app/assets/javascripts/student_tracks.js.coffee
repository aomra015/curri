$ = jQuery

$ ->

  # Show success criteria
  $('.sc-show-icon').on 'click', (e) ->
    e.preventDefault()
    Checkpoint.showCriteria($(this))

  # Rate checkpoint
  $('.choices-toggle').on 'click', (e) ->
    e.preventDefault()
    Checkpoint.openChoices($(this))

  $('.choices a').on "ajax:before", ->
    Checkpoint.closeChoices($(this))

  $('.choices a').on "ajax:success", (e, data) ->
    Checkpoint.updateRating(data)
    # SegmentIO event: Student Rates Checkpoint
    analytics.track "Rate checkpoint",
      score: data.current_score
      checkpoint_id: data.checkpoint_id
      classroom_id: data.classroom_id
      track_id: data.track_id