# ==== On page load do this! ====
$ = jQuery

$ ->

  # Activate jQuery libraries
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  # Student rating AJAX
  $('.choices a').on "ajax:success", (e, data) ->
    $checkpoint = $("#checkpoint#{data.checkpoint_id}")
    $checkpoint.find('.choices-toggle').fadeOut ->
      $(this).html(data.partial).fadeIn()
    $checkpoint.find('.choices').toggleClass('show')

    # SegmentIO event: Student Rates Checkpoint
    analytics.track "Rate checkpoint",
      score: data.current_score
      checkpoint_id: data.checkpoint_id
      classroom_id: data.classroom_id
      track_id: data.track_id

  # Update Header
  HelpStatusPoller.poll() if $('.help-toggle').length
  RequestNumberPoller.poll() if $('#requesters_link').length

  # Navigation Collapse
  CurriUiOptions.init() if $('.collapse-toggle').length

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
    # Hide hover label for Account when subnav is open
    $('.subnav-slide').toggleClass('nav-label-hide')

  # Page header style
  $(window).scroll ->
    if $(window).scrollTop() <= 25
      $('.page-header').removeClass('border')
    else
      $('.page-header').addClass('border')

  # SegmentIO event: Log out
  analytics.trackLink($('#logout-link'), "Sign out")

  # Student Track View
  $('.sc-show-icon').on 'click', (e) ->
    e.preventDefault()
    $(this).closest('.row').find('.success-criteria').toggleClass('success-criteria-show')

  # Show ratings for students
   $('.choices-toggle').on 'click', (e) ->
      e.preventDefault()
      $(this).closest('li').find('.choices').toggleClass('show')

  # Sidebar mobile select menu
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

  $('#sidebar-links select').on 'change', ->
    window.location = $(this).find("option:selected").val()