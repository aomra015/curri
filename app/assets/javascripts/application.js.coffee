# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.sortable
#= require pickadate/picker
#= require pickadate/picker.date
#= require pickadate/picker.time
#= require matchMedia
#= require uservoice
#= require bootstrap-dismiss
#= require utilities
#= require_tree ./objects
#= require_tree .

$ = jQuery

$ ->
  # Navigation
  if $('.fixed-nav').length
    Curri.MainNav.init()

    $('.collapse-toggle').on 'click', (e) ->
      e.preventDefault()
      $('body').toggleClass('nav-open')
      Curri.MainNav.update()
      Curri.SubNav.close()

    $('.subnav-toggle').on 'click', (e) ->
      e.preventDefault()
      Curri.SubNav.toggle()

  # Tracks & Analytics sidebar select menu
  if Curri.mobileScreen() && $('#track').length
    Curri.MobileSidebar.init()

  # SegmentIO
  if Curri.user
    userData =
      email: Curri.user.email
      classRole: Curri.user.classrole_type
      created: Curri.user.created_at
      firstName: Curri.user.first_name || 'No'
      lastName: Curri.user.last_name || 'Name'

    analytics.identify(Curri.user.id, userData)
    analytics.trackLink($('#logout-link'), "Sign out")