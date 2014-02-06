$ = jQuery

$ ->
  if $('#track').length && Curri.user.classrole_type == 'Student'
    # Show success criteria
    $('.sc-show-icon').on 'click', (e) ->
      e.preventDefault()
      Curri.Checkpoint.showCriteria($(this))

    # toggle all success criteria
    $('.sc-toggle').on 'click', (e) ->
      e.preventDefault()
      $('.success-criteria').toggleClass('success-criteria-show')

    # Rate checkpoint
    $('.choices-toggle').on 'click', (e) ->
      e.preventDefault()
      Curri.Checkpoint.openChoices($(this))

    $('.choices a').on "ajax:before", ->
      Curri.Checkpoint.closeChoices($(this))

    $('.choices a').on "ajax:success", (e, data) ->
      Curri.Checkpoint.updateRating(data)