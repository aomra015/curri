class @BarChart
  constructor: (@ratingsData, @element) ->
  scores: {}
  init: ->
    @getScores()
    @buildChart()
  getScores: ->
    zeroCount = 0
    oneCount = 0
    twoCount = 0

    for key, rating of @ratingsData
      if rating.score == 0
        zeroCount += 1
      else if rating.score == 1
        oneCount += 1
      else if rating.score == 2
        twoCount += 1

    @scores.zeroPercent = (zeroCount * 100 / @ratingsData.length) + "%"
    @scores.onePercent = (oneCount * 100 / @ratingsData.length) + "%"
    @scores.twoPercent = (twoCount * 100 / @ratingsData.length) + "%"
    @scores.zeroCount = zeroCount
    @scores.oneCount = oneCount
    @scores.twoCount = twoCount
  buildChart: ->
    @element.find('.count-number').html(@ratingsData.length)
    @element.find('.progress-bar-danger').css('width', @scores.zeroPercent).html(@scores.zeroCount)
    @element.find('.progress-bar-warning').css('width', @scores.onePercent).html(@scores.oneCount)
    @element.find('.progress-bar-success').css('width', @scores.twoPercent).html(@scores.twoCount)