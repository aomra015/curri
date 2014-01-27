$ = jQuery

$ ->

  # Show success criteria
  $('.sc-show-icon').on 'click', (e) ->
    e.preventDefault()
    $(this).closest('.row').find('.success-criteria').toggleClass('success-criteria-show')

  # Show ratings choice tooltip
   $('.choices-toggle').on 'click', (e) ->
      e.preventDefault()
      $(this).closest('li').find('.choices').toggleClass('show')

  # Rate checkpoint
  $('.choices a').on "ajax:before", ->
    $ratings = $(this).closest('.ratings')
    $ratings.find('.choices-toggle').fadeOut()
    $ratings.find('.choices').toggleClass('show')

  $('.choices a').on "ajax:success", (e, data) ->
    $("#checkpoint_#{data.checkpoint_id} .choices-toggle").html(data.partial).fadeIn()
    # SegmentIO event: Student Rates Checkpoint
    analytics.track "Rate checkpoint",
      score: data.current_score
      checkpoint_id: data.checkpoint_id
      classroom_id: data.classroom_id
      track_id: data.track_id