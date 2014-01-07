# ==== On page load do this! ====
$ = jQuery

$ ->

  # Activate jQuery libraries
  $('.success-criteria').popover({placement: 'left'})
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  # Student rating AJAX
  $('.checkpoint-score-links form').on "ajax:success", (e, data) ->
    marker = $("#checkpoint#{data.checkpoint_id}").find('.marker')
    marker.removeClass('checkpoint_0 checkpoint_1 checkpoint_2').fadeOut ->
      marker.addClass("checkpoint_#{data.current_score}").fadeIn()

  # Update Header
  # CLASSROOM_ID = $('#track_link').data('classroomid')
  # PrivatePub.subscribe "/classrooms/#{CLASSROOM_ID}/requesters", ({requester, requesters_count}) ->
  #   $('#requesters_link').text("Requesters (#{requesters_count})")
  #   $("#help_link#{requester}").text("I'm OK")

  # Navigation Collapse
  CurriUiOptions.init()

  $('.collapse-toggle').on 'click', ->
    $('body').toggleClass('nav-open')
    CurriUiOptions.update()
    $('.main').removeClass('subnav-open')
    $('.subnav').removeClass('show')

  # Subnav Toggle
  $('.subnav-toggle').on 'click', ->
    $('.main').toggleClass('subnav-open')
    $('.subnav').toggleClass('show')
