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
			second_number = results.count < results.limit_value ? results.count : results.limit_value
		else
			first_number = results.offset_value + 1
			if results.count == results.limit_value
				second_number = first_number + results.limit_value - 1
			else
				second_number = results.count + results.offset_value
			end
		end
		first_number.to_s + " - " + second_number.to_s
	end  #  def results_item_count_range_for_page(results)

	def current_item_number(results, count)
		if results.current_page == 1
			item_number = count
		else
			# item_number = count + results.offset
			item_number = count + results.offset_value
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

	def get_pdf_item_category(result)
		pdf_item = find_pdf_item_in_db(result)
		category = 'Uncategorized'	
		if pdf_item.present? && pdf_item.first.resource_type.present?
			category = pdf_item.first.resource_type
		end
		category
	end  #  def get_pdf_item_category(result)

	def get_pdf_item_title(result)
		pdf_item = find_pdf_item_in_db(result)
		if pdf_item.present?
				title = pdf_item.first.name
		else
			title = strip_html(result[:ResultTitle])
		end
		# title = pdf_item.present? ? pdf_item.name : 
		title		
	end  #  def get_pdf_item_title(result)

	def find_pdf_item_in_db(result)
		filename = URI.decode(File.basename(result[:Url]).split('#')[0].gsub("_original.pdf",".pdf"))
		pdf_item = Resource.where("resource_type is not null and include_in_pdf_search=1 and attachment_file_name = ?","#{filename}")
		pdf_item
	end  #  def find_pdf_item_in_db(result)

end  #  module SearchHelper
