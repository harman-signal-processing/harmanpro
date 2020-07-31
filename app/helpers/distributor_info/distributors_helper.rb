module DistributorInfo::DistributorsHelper
    
    def get_list_html(item, listname, keyname)
        listname_sym = listname.to_sym
        html = ""
    		if item[listname_sym].present?
    		 # key = listname.singularize
    			  item[listname_sym].each do |hash|
    			  	has_label = hash[:label].present?
    				  case listname
    				  when "emails"
    				    html += "<i class='far fa-envelope' aria-hidden='true'></i>&nbsp;#{mail_to hash[keyname.to_sym]}<br />"
    				  when "websites"
    				    html += "<i class='fas fa-external-link-alt' aria-hidden='true'></i>&nbsp;#{link_to hash[keyname.to_sym], hash[keyname.to_sym], target:"_blank"}<br />" if hash[keyname.to_sym].present?
    				  when "phones"
    						html += phone_html(has_label, hash, keyname)
    				  else
    				    html += "#{hash[keyname.to_sym]}<br />"
    				  end
    			end # item[listname_sym].each do |hash|
    		end  # if item[symbol].present?
        html
    end  #  def get_list_html(item, listname, keyname)

    def address_html(item)
        html = ""
    	html += "#{item[:address1]}<br />"
    	if item[:address2].present?
    		html += "#{item[:address2]}<br />"
    	end
    	if item[:address3].present?
    		html += "#{item[:address3]}<br />"
    	end
    	html += "#{item[:city]} "
    	if item[:state].present?
    		html += " #{item[:state]} "
    	end
    	html += "#{item[:postal]}<br />"
    	html += country_name(item[:country])
    end  #  def address_html(item)

    def phone_html(has_label, hash, keyname)
    	html = ""
      	if has_label && hash[:label].downcase == "fax"
      		html += "<i class='fas fa-fax' aria-hidden='true'></i>&nbsp;" 
      	else
      		html += "<i class='fas fa-phone' aria-hidden='true'></i>&nbsp;"
      	end
    
    	  html += "#{hash[:label]}: " if has_label
      	html += "#{hash[keyname.to_sym]}<br />"		
      	
      	html
    end  #  def phone_html(has_label, hash, keyname)    
    
    def country_name(country_code)
        cache_for = Rails.env.production? ? 8.hours : 1.minute
        Rails.cache.fetch(country_code, expires_in: cache_for, race_condition_ttl: 10) do
            country_info = LocationInfo::Country.where("alpha2 = ?",country_code)
            country_name = country_info.present? ? country_info.first[:harman_name] : ""
            country_name
        end  #  Rails.cache.fetch(country_code, expires_in: cache_for, race_condition_ttl: 10) do
    end  #  def country_name(country_code)   
    
end  #  module DistributorInfo::DistributorsHelper
