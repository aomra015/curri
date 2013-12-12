describe 'Test', ->
  it 'loads fixtures', ->
    $container = affix('.container')
    expect($container).toEqual($('.container'))

  it 'loads more fixtures', ->
    $container = affix('#container')
    expect($container).toNotEqual($('#not-container'))