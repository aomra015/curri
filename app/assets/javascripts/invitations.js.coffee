$ = jQuery

$ ->
  # Delete invitation (remove student from class)
  if $('#invitations').length
    $('#invitations .danger-link').on "ajax:success", (e, data)->
      $("#invitation_#{data.id}").fadeOut 'slow', ->
        $(this).remove()