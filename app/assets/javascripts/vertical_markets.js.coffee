jQuery ($) ->

  $(".parent-category-container").each ->
    bg = $(@).data('background')
    $(@).css("background-image": "url(#{bg})")

  $(window).bind 'scroll', ->
    parallaxScroll()

  parallaxScroll = ->
    scrolled = $(window).scrollTop()
    $("#bubble-1").css(top: "#{(230 - (scrolled*1.1))}px")
    $("#bubble-2").css(top: "#{(450 - (scrolled*1.05))}px")
    $("#bubble-3").css(top: "#{(900 - (scrolled*1.2))}px")
    #$(".parent-category-container").css('background-position': "0 #{(scrolled)}px")

  $("img.infographic").each ->
    i = $(@)
    hover_image = new Image
    hover_image.src = i.data 'hover'
    original_src = i.attr 'src'
    i.hover(
      -> i.attr 'src', hover_image.src
      -> i.attr 'src', original_src
    )
