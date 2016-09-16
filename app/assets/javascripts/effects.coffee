jQuery ($) ->

  $(".vm-big-button").each ->
    bg = $(@).data('background')
    $(@).css("background-image": "url(#{bg})")

  $(".stretchy-image-container").each ->
    bg = $(@).data('background')
    $(@).css("background-image": "url(#{bg})")
