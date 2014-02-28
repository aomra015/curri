$ = jQuery

$ ->
  # Update Header
  if $('#student-help-toggle').length
    Curri.channel ?= Curri.pusher.subscribe("classroom#{$('#student-help-toggle').data('classroom-id')}-requesters")
    Curri.channel.bind 'notifyStudent', (data) ->
      if data.requesterId == $('#student-help-toggle').data('requester-id')
        Curri.HelpStatus.helpToggle({ help: data.HelpStatus })

    $('#student-help-toggle a').on 'ajax:success', (e, data) ->
      Curri.HelpStatus.helpToggle(data)
      Curri.HelpStatus.showTooltip(data)

  if $('#requesters_link').length
    Curri.channel ?= Curri.pusher.subscribe("classroom#{$('#requesters_link').data('classroom-id')}-requesters")
    Curri.channel.bind 'requestUpdate', (data) ->
      Curri.RequestsNumber.update(data)

  if $('#classrooms').length && Curri.user.classrole_type == 'Teacher'
    $('#new_classroom').on "ajax:success", (e, data, status, xhr) ->
      Curri.clear_modal()
      $('.grid-unit').last().after($(data.partial).fadeIn('slow'))

    $('#new_classroom').on "ajax:error", (e, xhr, status, error) ->
      Curri.form_validations('classroom', JSON.parse(xhr.responseText))

    $('#join_classroom').on "ajax:success", (e, data, status, xhr) ->
      Curri.clear_modal()
      $('.grid-unit').last().after($(data.partial).fadeIn('slow'))

    $('#join_classroom').on "ajax:error", (e, xhr, status, error) ->
      Curri.form_validations('teacher', {token: xhr.responseText})

