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
    scores = getScores(ratings)

    checkpoint_row.find('.progress-bar-danger').css('width', scores.zeroPercent).html(scores.zeroCount)
    checkpoint_row.find('.progress-bar-warning').css('width', scores.onePercent).html(scores.oneCount)
    checkpoint_row.find('.progress-bar-success').css('width', scores.twoPercent).html(scores.twoCount)

    #update student view
    marker = $("#checkpoint#{checkpoint}").find('.marker')
    marker.removeClass('checkpoint_0 checkpoint_1 checkpoint_2').fadeOut ->
      marker.addClass("checkpoint_#{current_score}").fadeIn()

getScores = (ratings) ->
  zeroCount = 0
  oneCount = 0
  twoCount = 0

  for key, rating of ratings
    if rating.score == 0
      zeroCount += 1
    else if rating.score == 1
      oneCount += 1
    else if rating.score == 2
      twoCount += 1
  {
    zeroPercent: (zeroCount * 100 / ratings.length) + "%",
    onePercent: (oneCount * 100 / ratings.length) + "%",
    twoPercent: (twoCount * 100 / ratings.length) + "%",
    zeroCount: zeroCount,
    oneCount: oneCount,
    twoCount: twoCount
  }