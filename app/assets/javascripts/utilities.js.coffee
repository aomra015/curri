@Curri ?= {}

@Curri.supports_html5_storage = ->
  try
    return "localStorage" of window and window["localStorage"] isnt null
  catch e
    return false

@Curri.largeScreen = ->
  return window.matchMedia("(min-width: 1024px)").matches

@Curri.mobileScreen = ->
  return window.matchMedia("(max-width: 480px)").matches