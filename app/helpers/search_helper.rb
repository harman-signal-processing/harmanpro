module SearchHelper

  # Figure out what the link to a give Page should be
  def page_link(page)
    if page.is_a?(LandingPage)
      (page.custom_slug.blank?) ?
        landing_page_url(page, locale: I18n.locale) :
        custom_page_url(page) #custom_route_url(page.custom_route)
    else
      (Rails.env.production? || Rails.env.staging?) ?
        "#{request.protocol}#{request.host}#{url_for(page)}" :
        "#{request.protocol}#{request.host_with_port}#{url_for(page)}"
    end
  end

  def custom_page_url(page)
    (Rails.env.production? || Rails.env.staging?) ?
      "#{request.protocol}#{request.host}/lp/#{page.custom_slug}" :
      "#{request.protocol}#{request.host_with_port}/lp/#{page.custom_slug}"
  end

  # Remove HTML from a string (helpful for truncated intros of
  # pre-formatted HTML)
  def strip_html(string="")
    begin
      string = string.gsub(/<\/?[^>]*>/,  "")
      string = string.gsub(/\&+\w*\;/, " ") # replace &nbsp; with a space
      string.html_safe
    rescue
      raw("<!-- error stripping html from: #{string} -->")
    end
  end


end
