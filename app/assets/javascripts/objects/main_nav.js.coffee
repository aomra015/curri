@Curri.MainNav =
  init: ->
    if Curri.supports_html5_storage()
      if Curri.largeScreen()
        # Defaults
        localStorage["expandNav"] ?= true
        # Build UI
        $('body').toggleClass('nav-open', JSON.parse(localStorage["expandNav"]))
      else
        localStorage.removeItem("expandNav")

  update: ->
    if Curri.supports_html5_storage() && Curri.largeScreen()
      if $('body').hasClass('nav-open')
        localStorage["expandNav"] = true
      else
        localStorage["expandNav"] = false