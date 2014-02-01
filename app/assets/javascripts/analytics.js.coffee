$ = jQuery

$ ->
  if ('.analytics-content').length
    # Phase select
    $('#phase-selector select').on 'change', ->
      $(this).closest('form').submit()

    # Show students that haven't voted
    $('.students-toggle').on 'click', (e) ->
      e.preventDefault()
      $(this).closest('.row').find('.hasnt-voted').toggleClass('hasnt-voted-show')