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
#= require_tree .

$ = jQuery

$ ->
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

  # SegmentIO
  if @Curri && @Curri.user
    userData =
      email: Curri.user.email
      classRole: Curri.user.classrole_type
      created: Curri.user.created_at
      firstName: Curri.user.first_name || 'No'
      lastName: Curri.user.last_name || 'Name'

    analytics.identify(Curri.user.id, userData)

  analytics.trackLink($('#logout-link'), "Sign out")