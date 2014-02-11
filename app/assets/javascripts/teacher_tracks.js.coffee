$ = jQuery

$ ->
  # Activate pickadate
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  if $('#track').length && Curri.user.classrole_type == 'Teacher'
    # Delete Checkpoints
    $('.expectation-actions .trash-icon').on "ajax:success", (e, data)->
      Curri.Checkpoint.remove(data.id)

    # Checkpoints sort
    Curri.Checkpoint.sortable()

  $('.tracks').sortable
    items: "> div.grid-unit"
    handle: '.unit-header'
    cursor: 'move'
    placeholder: "track-drop-highlight padding-border"
    start: (e, ui) ->
      ui.placeholder.height(ui.item.height())
      ui.placeholder.width(ui.item.width())
    update: ->
      $.post($(this).data('url'), $(this).sortable('serialize'))