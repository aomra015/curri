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
    Checkpoint.remove(data.id)

  # Checkpoints sort
  if Curri && Curri.user.classrole_type == 'Teacher'
    Checkpoint.sortable()