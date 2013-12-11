class @BarChart
  constructor: (@ratingsData, @element) -> @scores = {}
  init: ->
    @getScores()
    @buildChart()
  getScores: ->
    count = [0, 0, 0]

    for rating in @ratingsData
      count[rating.score] += 1

    numberOfRatings = @ratingsData.length
    percents = count.map (c) -> (c * 100 / numberOfRatings) + "%"

    @scores.zeroPercent = percents[0]
    @scores.onePercent = percents[1]
    @scores.twoPercent = percents[2]
    @scores.zeroCount = count[0]
    @scores.oneCount = count[1]
    @scores.twoCount = count[2]
  buildChart: ->
    @element.find('.count-number').html(@ratingsData.length)
    @element.find('.progress-bar-danger').css('width', @scores.zeroPercent).html(@scores.zeroCount)
    @element.find('.progress-bar-warning').css('width', @scores.onePercent).html(@scores.oneCount)
    @element.find('.progress-bar-success').css('width', @scores.twoPercent).html(@scores.twoCount)