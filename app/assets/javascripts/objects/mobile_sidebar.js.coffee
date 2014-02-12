@Curri.MobileSidebar =
  init: ->
    @hideLinks()
    @buildSelector()
    @buildOptions()
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
      highlight = el.closest('.row').hasClass('highlight')
      $("<option />", {
           "value"   : el.attr("href"),
           "text"    : if highlight then '>> ' + el.text() else el.text()
       }).appendTo("#sidebar-links select")

  hideLinks: ->
    $('#sidebar-links ul').hide()

  onSubmit: ->
    $('#sidebar-links select').on 'change', ->
      window.location = $(this).find("option:selected").val()