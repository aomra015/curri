@CurriUiOptions =
  init: ->
    if @supports_html5_storage()
      if @largeScreen()
        # Defaults
        localStorage["expandNav"] ?= true
        # Build UI
        $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))
      else
        localStorage.removeItem("expandNav")

  update: ->
    if @supports_html5_storage() && @largeScreen()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false

  # Helpers
  supports_html5_storage: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false

  largeScreen: ->
    return window.matchMedia("(min-width: 1024px)").matches

  mobileScreen: ->
    return window.matchMedia("(max-width: 480px)").matches