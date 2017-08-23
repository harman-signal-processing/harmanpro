# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

  $('input.colorpicker').spectrum
    preferredFormat: "hex"
    showInput: true

  class ChannelManagerBox
    constructor: (@this_form) ->
      @country_select = $(@this_form).find("select#country")
      @channel_select = $(@this_form).find("select#channel")
      @country_id = ''
      @channel_id = ''
      @channel_managers = {}
      @content_container = $("div#channel-manager-content")
      @spinner = $("<div class='placeholder'><p><img src='#{ @content_container.data('loading') }' alt='loading'></p></div>")
      @load_channels()
      @load_countries()
      @handle_change()

    load_channels: =>
      url = "/emea/channels.json"
      $.getJSON url, (data) =>
        $.each data.channels, (key, channel) =>
          @channel_select.append $("<option value='#{channel.id}'>#{channel.name}</option>")
        @channel_select.find("option.loading").html('Select A Channel...').val('')

    load_countries: =>
      url = "/emea/channel_countries.json"
      $.getJSON url, (data) =>
        $.each data.channel_countries, (key, country) =>
          @country_select.append $("<option value='#{country.id}'>#{country.name}</option>")
        @country_select.find("option.loading").html('Select A Country...').val('')

    handle_change: =>
      @country_select.change (e) =>
        @country_id = @country_select.val()
        @build_or_retrieve_panel()
      @channel_select.change (e) =>
        @channel_id = @channel_select.val()
        @build_or_retrieve_panel()

    build_or_retrieve_panel: =>
      panel = $("<div></div>")
      if @country_id.length && @channel_id.length
        search_url = "/emea/channel/#{ @channel_id }/country/#{ @country_id }/managers.json"
        $.getJSON search_url, (data) =>
          $.each data.channel_managers, (key, channel_manager) =>
            panel.append("<h5>#{channel_manager.name}</h5>")
            if channel_manager.email
              panel.append("<p><i class=\"fa fa-envelope\" aria-hidden=\"true\"></i>&nbsp;<a href=\"mailto:#{ channel_manager.email }\">#{ channel_manager.email }</a></p>" )
            if channel_manager.telephone
              panel.append("<p><i class=\"fa fa-phone\" aria-hidden=\"true\"></i>&nbsp;#{ channel_manager.telephone }</p>")
          @content_container.html( panel )

  $("form#channel-manager-search").each -> new ChannelManagerBox(@)
