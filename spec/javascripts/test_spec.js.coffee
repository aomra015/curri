describe 'Test', ->
  it 'loads fixtures', ->
    loadFixtures('myfixture.html')
    expect($('.container')).toExist()
    expect($('#container')).not.toExist()