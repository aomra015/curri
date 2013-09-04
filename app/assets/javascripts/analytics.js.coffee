# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require private_pub

$ ->
  TRACK_ID = $('#track').data('trackid')
  PrivatePub.subscribe "/track/#{TRACK_ID}/ratings", ({checkpoint, ratings, current_score}) ->

    #update analytics view
    checkpoint_row = $("#checkpoint#{checkpoint}")
    checkpoint_row.find('.count-number').html(ratings.length)
    scores = get_score(ratings)

    checkpoint_row.find('.progress-bar-danger').css('width', scores.zero_percent).html(scores.zero_count)
    checkpoint_row.find('.progress-bar-warning').css('width', scores.one_percent).html(scores.one_count)
    checkpoint_row.find('.progress-bar-success').css('width', scores.two_percent).html(scores.two_count)

    #update student view
    marker = $("#checkpoint#{checkpoint}").find('.marker')
    marker.removeClass('checkpoint_0 checkpoint_1 checkpoint_2')
    marker.addClass("checkpoint_#{current_score}")

get_score = (ratings) ->
  zero_count = 0
  one_count = 0
  two_count = 0

  for key, rating of ratings
    if rating.score == 0
      zero_count += 1
    else if rating.score == 1
      one_count += 1
    else if rating.score == 2
      two_count += 1

  zero_percent = zero_count * 100 / ratings.length
  one_percent = one_count * 100 / ratings.length
  two_percent = two_count * 100 / ratings.length
  {
    zero_percent: "#{zero_percent}%",
    one_percent: "#{one_percent}%",
    two_percent: "#{two_percent}%",
    zero_count: zero_count,
    one_count: one_count,
    two_count: two_count
  }