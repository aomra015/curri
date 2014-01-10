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
  HelpStatusPoller.poll() if $('.help-toggle').length
  RequestNumberPoller.poll() if $('#requesters_link').length

  # Navigation Collapse
  CurriUiOptions.init()

  $('.collapse-toggle').on 'click', (e) ->
    e.preventDefault()
    $('body').toggleClass('nav-open')
    CurriUiOptions.update()
    $('.main').removeClass('subnav-open')
    $('.subnav').removeClass('subnav-show')

  # Subnav Toggle
  $('.subnav-toggle').on 'click', (e) ->
    e.preventDefault()
    $('.main').toggleClass('subnav-open')
    $('.subnav').toggleClass('subnav-show')

  # Page header style
  $(window).scroll ->
    if $(window).scrollTop() <= 25
      $('.page-header').removeClass('border')
    else
      $('.page-header').addClass('border')

  # Animate Requesters number when it changes
  $(document).ready ->
    $('window').load ->
    $('.req-num').addClass('load')
