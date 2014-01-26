# ==== On page load do this! ====
$ = jQuery

$ ->

  # Activate jQuery libraries
  $('#track_start_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_end_date').pickadate({ format: "yyyy-mm-dd" })
  $('#track_start_time').pickatime({format: 'hh:i a'})
  $('#track_end_time').pickatime({format: 'hh:i a'})

  # Student rating AJAX
  $('.choices a').on "ajax:before", ->
    $ratings = $(this).closest('.ratings')
    $ratings.find('.choices-toggle').fadeOut()
    $ratings.find('.choices').toggleClass('show')

  $('.choices a').on "ajax:success", (e, data) ->
    $("#checkpoint_#{data.checkpoint_id} .choices-toggle").html(data.partial).fadeIn()

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
  # $(window).scroll ->
  #   if $(window).scrollTop() <= 25
  #     $('.page-header').removeClass('border')
  #   else
  #     $('.page-header').addClass('border')

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

  # Tracks AJAX
  $('.expectation-actions .trash-icon').on "ajax:success", (e, data)->
    $("#checkpoint_#{data.id}").fadeOut 'slow', ->
      $(this).remove()

  # Invitations AJAX
  $('#invitations .danger-link').on "ajax:success", (e, data)->
    $("#invitation_#{data.id}").fadeOut 'slow', ->
      $(this).remove()

  # Requesters AJAX
  $('#requesters-table').on "ajax:success", '.btn-small', (e, data)->
    $("#requester#{data.id}").fadeOut 'slow', ->
      $(this).remove()
    # SegmentIO event
    analytics.track "Teacher Answered Student"

  # Help-toggle AJAX
  $('.help-toggle a').on 'ajax:success', (e, data) ->
    HelpStatusPoller.helpToggle(data)
    $('#help-tooltip').show
    $helpTooltip = $('#help-tooltip').text(data.message).show()
    hideTooltip = -> $helpTooltip.fadeOut()
    setTimeout(hideTooltip, 2000)

  # Checkpoints sort
  if Curri && Curri.user.classrole_type == 'Teacher'
    $('.checkpoints').sortable
      items: "> div.row"
      handle: '.expectation'
      cursor: 'move'
      axis: 'y'
      placeholder: ".checkpoint-drop-highlight"
      update: ->
        $.post($(this).data('url'), $(this).sortable('serialize'))