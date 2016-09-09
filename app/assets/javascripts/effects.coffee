jQuery ($) ->

  $(".vm-big-button").each ->
    bg = $(@).data('background')
    $(@).css("background-image": "url(#{bg})")
