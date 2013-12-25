class @RatingsCounter
  constructor: (@ratingsData, @totalStudentCount) ->
  init: ->
    count = [0, 0, 0]
    for rating in @ratingsData
      count[rating.score] += 1

    ratings = { totalCount: @ratingsData.length, totalStudentCount: @totalStudentCount }
    percents = count.map (c) -> (c * 100 / ratings.totalStudentCount)

    ratings.zeroPercent = percents[0]
    ratings.onePercent = percents[1]
    ratings.twoPercent = percents[2]
    ratings.zeroCount = count[0]
    ratings.oneCount = count[1]
    ratings.twoCount = count[2]
    ratings.emptyCount = ratings.totalStudentCount - ratings.totalCount
    ratings.emptyPercent = (ratings.emptyCount * 100 / ratings.totalStudentCount)
    ratings

$ = jQuery
$.fn.barChart = (data) ->
  return @each () ->
    $(this).find('.count-number').html(data.totalCount)
    $(this).find('.progress-bar-danger').css('width', data.zeroPercent + "%").html(data.zeroCount)
    $(this).find('.progress-bar-warning').css('width', data.onePercent + "%").html(data.oneCount)
    $(this).find('.progress-bar-success').css('width', data.twoPercent + "%").html(data.twoCount)
    $(this).find('.progress-bar-empty').css('width', data.emptyPercent + "%").html(data.emptyCount)