@MobileSidebar =
  init: ->
    @buildSelector()
    @buildOptions()
    @hideLinks()
    @onSubmit()

  buildSelector: ->
    $("<select />").appendTo("#sidebar-links")
    $("<option />", {
       "selected": "selected",
       "value"   : "",
       "text"    : "Go to..."
    }).appendTo("#sidebar-links select")

  buildOptions: ->
    $('#sidebar-links a').each ->
      el = $(this)
      $("<option />", {
           "value"   : el.attr("href"),
           "text"    : el.text()
       }).appendTo("#sidebar-links select")

  hideLinks: ->
    $('#sidebar-links ul').hide()

  onSubmit: ->
    $('#sidebar-links select').on 'change', ->
      window.location = $(this).find("option:selected").val()