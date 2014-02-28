#= require utilities
#= require objects/bar_chart

describe 'RatingsCounter', ->

  test = {}
  beforeEach ->
    data = "[{\"score\":0},{\"score\":1},{\"score\":0}]" #JSON
    test.result = Curri.RatingsCounter.init(data, 4)

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
    test.counts = Curri.RatingsCounter.init(data, 4)

    loadFixtures('analytics-checkpoint.html')
    test.checkpoint = $("#checkpoint").barChart(test.counts)

    # hack to get % rather than px widths
    test.checkpoint.find('.progress').hide()

  describe 'Display of counts', ->
    it 'should display percent of zero ratings', ->
      expect(test.checkpoint.find('.progress-bar-danger + .progress-bar-label').text()).toEqual('2')

    it 'should display percent of one ratings', ->
      expect(test.checkpoint.find('.progress-bar-warning + .progress-bar-label').text()).toEqual('1')

    it 'should display percent of two ratings', ->
      expect(test.checkpoint.find('.progress-bar-success + .progress-bar-label').text()).toEqual('0')

    it 'should display percent of no ratings', ->
      expect(test.checkpoint.find('.progress-bar-empty + .progress-bar-label').text()).toEqual('1')

  describe 'Display of bar widths', ->
    it 'should draw red portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-danger').parents('.progress-bar').css('width'))
      expected = test.counts.zeroPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw orange portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-warning').parents('.progress-bar').css('width'))
      expected = test.counts.onePercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw green portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-success').parents('.progress-bar').css('width'))
      expected = test.counts.twoPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should draw blank portion of bar', ->
      result = parseFloat(test.checkpoint.find('.progress-bar-empty').parents('.progress-bar').css('width'))
      expected = test.counts.emptyPercent
      expect(result).toBeCloseTo(expected,3)

    it 'should contain a percent sign', ->
      expect(test.checkpoint.find('.progress-bar-danger').parents('.progress-bar').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-warning').parents('.progress-bar').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-success').parents('.progress-bar').css('width')).toMatch(/\d+\%/)
      expect(test.checkpoint.find('.progress-bar-empty').parents('.progress-bar').css('width')).toMatch(/\d+\%/)