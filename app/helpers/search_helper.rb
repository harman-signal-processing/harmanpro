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

	def results_item_count_range_for_page(results)
	  
		if results.current_page == 1
			first_number = 1
			second_number = results.per_page
		else
			first_number = results.offset + 1
			if results.count == results.per_page
				second_number = first_number + results.per_page - 1
			else
				second_number = results.count + results.offset
			end
		end
		first_number.to_s + " - " + second_number.to_s
	end  #  def results_item_count_range_for_page(results)

	def current_item_number(results, count)
		if results.current_page == 1
			item_number = count
		else
			item_number = count + results.offset
		end
		
		item_number
	end  #  def current_item_number(results, count)
	
	def category_name(result_class_name)
		t("search_page.#{result_class_name.downcase}").titleize
	end
	
	def get_result_image(item)
		begin
			case item.class.name
			when "CaseStudy", "LandingPage","VerticalMarket"
			  if item.banner.present?
				  image = item.banner.url(:thumb_square) if item.banner.present?
				end
			else
				# image = image_url("/images/harmanpro-logo.png")
			end  # case result.class.name
		rescue
			image = image_url("/images/harmanpro-logo.png")
		end
		image
		
	end  #  def get_result_image(item)	

end
