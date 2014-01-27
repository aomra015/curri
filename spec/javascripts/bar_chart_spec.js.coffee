#= require objects/bar_chart

describe 'RatingsCounter', ->

  test = {}
  beforeEach ->
    data = "[{\"score\":0},{\"score\":1},{\"score\":0}]" #JSON
    myRatingsCounter = new RatingsCounter(data, 4)
    test.result = myRatingsCounter.init()

  it 'should count rating scores', ->
    expect(test.result.zeroCount).toEqual(2)
    expect(test.result.oneCount).toEqual(1)
    expect(test.result.twoCount).toEqual(0)
    expect(test.result.emptyCount).toEqual(1)
    expect(test.result.totalCount).toEqual(3)

  it 'should calculate percentages', ->
    expect(test.result.zeroPercent).toBeCloseTo(50.0,3)
    expect(test.result.onePercent).toBeCloseTo(25.0,3)
    expect(test.result.twoPercent).toBeCloseTo(0,3)
    expect(test.result.emptyPercent).toBeCloseTo(25.0,3)

describe 'BarChart jQuery Plugin', ->

  test = {}
  beforeEach ->
    data = "[{\"score\":0},{\"score\":1},{\"score\":0}]" #JSON
    myRatingsCounter = new RatingsCounter(data, 4)
    test.counts = myRatingsCounter.init()

    loadFixtures('analytics-checkpoint.html')
    test.checkpoint = $("#checkpoint").barChart(test.counts)

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

    it 'should display number of no ratings', ->
      expect(test.checkpoint.find('.progress-bar-empty')).toContainText(test.counts.emptyCount)

  describe 'Display of bar', ->
    it 'should draw red portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-danger').css('width'))
      expected = test.counts.zeroPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw orange portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-warning').css('width'))
      expected = test.counts.onePercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw green portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-success').css('width'))
      expected = test.counts.twoPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw blank portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-empty').css('width'))
      expected = test.counts.emptyPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should contain a percent sign', ->
      expect(test.checkpoint.find('.progress-bar-danger').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-warning').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-success').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-empty').css('width')).toMatch(/\d+\%/)