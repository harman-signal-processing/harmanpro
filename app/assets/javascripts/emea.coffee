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

  class EmployeeLookup
    constructor: (@this_form) ->
      @department_select = $(@this_form).find("select#department")
      @job_function_select = $(@this_form).find("select#job_function")
      @department_id = ''
      @job_function_id = ''
      @contacts = {}
      @content_container = $("div#contacts-content")
      @load_departments()
      @job_function_container = $("div#job-function-container")
      @job_function_container.hide()
      @handle_change()

    load_departments: =>
      url = "/emea/departments.json"
      $.getJSON url, (data) =>
        $.each data.employee_contacts, (key, department) =>
          @department_select.append $("<option value='#{department}'>#{department}</option>")
        @department_select.find("option.loading").html('Select A Department...').val('')

    load_job_functions: =>
      @job_function_container.hide()
      @job_function_select.children().remove()
      @job_function_select.append $("<option class='loading'>loading...</option>")
      url = "/emea/department/#{ @department_id }/job_functions.json"
      $.getJSON url, (data) =>
        $.each data.employee_contacts, (key, job_function) =>
          @job_function_select.append $("<option value='#{job_function}'>#{job_function}</option>")
        @job_function_select.find("option.loading").html('Select A Function...').val('')
        @job_function_container.show()

    handle_change: =>
      @department_select.change (e) =>
        @department_id = @department_select.val()
        @load_job_functions()
        @content_container.empty()
      @job_function_select.change (e) =>
        @job_function_id = @job_function_select.val()
        @build_or_retrieve_panel()

    build_or_retrieve_panel: =>
      panel = $("<div></div>")
      if @department_id.length && @job_function_id.length
        search_url = "/emea/department/#{ @department_id }/job_function/#{ @job_function_id }/contacts.json"
        $.getJSON search_url, (data) =>
          $.each data.employee_contacts, (key, contact) =>
            panel.append("<div><h5>#{contact.name}</h5>")
            if contact.position
              panel.append("#{ contact.position }<br/>")
            if contact.email
              panel.append("<i class=\"fa fa-envelope\" aria-hidden=\"true\"></i>&nbsp;<a href=\"mailto:#{ contact.email }\">#{ contact.email }</a></br>" )
            if contact.telephone
              panel.append("<i class=\"fa fa-phone\" aria-hidden=\"true\"></i>&nbsp;#{ contact.telephone }</br>")
            if contact.mobile
              panel.append("<i class=\"fa fa-mobile fa-lg\" aria-hidden=\"true\"></i>&nbsp;#{ contact.mobile } (mobile)</br>")
            if contact.brands
              panel.append("Brands: #{ contact.brands }<br/>")
            if contact.country
              panel.append("Country: #{ contact.country }<br/>")
            panel.append("</div><hr/>")
          @content_container.html( panel )

  $("form#employee-lookup").each -> new EmployeeLookup(@)

