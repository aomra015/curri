@CurriUiOptions =
  init: ->
    if @supports_html5_storage()
      if @largeScreen()
        # Defaults
        localStorage["expandNav"] ?= true
      else
        localStorage.removeItem("expandNav")

  build_from_localstorage: ->
    if @supports_html5_storage() && @largeScreen()
      $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))

  change_localstorage: ->
    if @supports_html5_storage() && @largeScreen()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false

  supports_html5_storage: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false

  largeScreen: ->
    return window.matchMedia("(min-width: 1024px)").matches