class @CurriUiOptions
  supports_html5_storage: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false

  build_from_localstorage: ->
    if @supports_html5_storage()
      if localStorage["collapseNav"] == "true"
        $('body').removeClass('nav-open')
      else
        $('body').addClass('nav-open') # default

  change_localstorage: ->
    if @supports_html5_storage()
      localStorage["collapseNav"] = false # default
      localStorage["collapseNav"] = true if !$('body').hasClass('nav-open')