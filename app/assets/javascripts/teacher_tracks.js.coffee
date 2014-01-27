$ = jQuery

$ ->
  # Activate pickadate
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  # Tracks sidebar select menu
  if CurriUiOptions.mobileScreen()
    MobileSidebar.init()

  # Delete Checkpoints
  $('.expectation-actions .trash-icon').on "ajax:success", (e, data)->
    $("#checkpoint_#{data.id}").fadeOut 'slow', ->
      $(this).remove()

  # Checkpoints sort
  if Curri && Curri.user.classrole_type == 'Teacher'
    $('.checkpoints').sortable
      items: "> div.row"
      handle: '.expectation'
      cursor: 'move'
      axis: 'y'
      placeholder: "checkpoint-drop-highlight expectation content"
      start: (e, ui) ->
        ui.placeholder.height(ui.item.height())
        ui.placeholder.width(ui.item.width())
      update: ->
        $.post($(this).data('url'), $(this).sortable('serialize'))