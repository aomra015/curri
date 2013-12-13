#= require bar_chart

describe 'RatingsCounter', ->

  test = {}
  beforeEach ->
    data = [{score: 0}, {score: 1}, {score: 0}]
    myRatingsCounter = new RatingsCounter(data)
    test.result = myRatingsCounter.init()

  it 'should count rating scores', ->
    expect(test.result.zeroCount).toEqual(2)
    expect(test.result.oneCount).toEqual(1)
    expect(test.result.twoCount).toEqual(0)
    expect(test.result.totalCount).toEqual(3)

  it 'should calculate percentages', ->
    expect(test.result.zeroPercent).toEqual('66.66666666666667%')
    expect(test.result.onePercent).toEqual('33.333333333333336%')
    expect(test.result.twoPercent).toEqual('0%')

describe 'BarChart jQuery Plugin', ->

  test = {}
  beforeEach ->
    data = [{score: 0}, {score: 1}, {score: 0}]
    myRatingsCounter = new RatingsCounter(data)
    test.counts = myRatingsCounter.init()

    loadFixtures('student-checkpoint.html')
    $("#checkpoint").barChart(test.counts)
    test.checkpoint = $("#checkpoint")

    # hack to get % rather than px widths
    test.checkpoint.find('.progress').hide()

  describe 'Display of counts', ->
    it 'should display number of total ratings', ->
      expect(test.checkpoint.find('.count-number')).toContainText(test.counts.totalCount)

    it 'should display number of zero ratings', ->
      expect(test.checkpoint.find('.progress-bar-danger')).toContainText(test.counts.zeroCount)

    it 'should display number of one ratings', ->
      expect(test.checkpoint.find('.progress-bar-warning')).toContainText(test.counts.oneCount)

    it 'should display number of two ratings', ->
      expect(test.checkpoint.find('.progress-bar-success')).toContainText(test.counts.twoCount)

  describe 'Display of bar', ->
    it 'should draw red portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-danger').css('width')).toFixed(4)
      expected = parseFloat(test.counts.zeroPercent).toFixed(4)
      expect(result).toEqual(expected)

    it 'should draw orange portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-warning').css('width')).toFixed(4)
      expected = parseFloat(test.counts.onePercent).toFixed(4)
      expect(result).toEqual(expected)

    it 'should draw green portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-success').css('width')).toFixed(4)
      expected = parseFloat(test.counts.twoPercent).toFixed(4)
      expect(result).toEqual(expected)