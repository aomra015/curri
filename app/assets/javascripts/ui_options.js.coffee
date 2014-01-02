class @CurriUiOptions
  supports_html5_storage: ->
    try
      return "localStorage" of window and window["localStorage"] isnt null
    catch e
      return false

  build_from_localstorage: ->
    if @supports_html5_storage()
      if localStorage["collapseNav"] == "false"
        $('body').addClass('nav-open')
      else
        $('body').removeClass('nav-open')

  change_localstorage: ->
    if @supports_html5_storage()
      localStorage["collapseNav"] = true # default
      localStorage["collapseNav"] = false if $('body').hasClass('nav-open')