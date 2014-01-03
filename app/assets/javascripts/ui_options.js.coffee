class @CurriUiOptions
  constructor: ->
    if @supports_html5_storage()
      # Defaults
      localStorage["expandNav"] ?= true

  build_from_localstorage: ->
    if @supports_html5_storage()
      $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))

  change_localstorage: ->
    if @supports_html5_storage()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false

  supports_html5_storage: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false