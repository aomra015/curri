$ = jQuery

$ ->
  # Delete invitation (remove student from class)
  $('#invitations .danger-link').on "ajax:success", (e, data)->
    $("#invitation_#{data.id}").fadeOut 'slow', ->
      $(this).remove()