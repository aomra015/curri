$ = jQuery

$ ->
  # Activate pickadate
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  # Sidebar mobile select menu
  if CurriUiOptions.mobileScreen()
    $("<select />").appendTo("#sidebar-links")
    $("<option />", {
       "selected": "selected",
       "value"   : "",
       "text"    : "Go to..."
    }).appendTo("#sidebar-links select")

    $('#sidebar-links a').each ->
      el = $(this)
      $("<option />", {
           "value"   : el.attr("href"),
           "text"    : el.text()
       }).appendTo("#sidebar-links select")

    $('#sidebar-links ul').hide()

    $('#sidebar-links select').on 'change', ->
      window.location = $(this).find("option:selected").val()

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