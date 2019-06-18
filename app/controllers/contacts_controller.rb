class ContactsController < ApplicationController

    def show
        search_term = params[:search].downcase
        chosen_contacts_path = params[:chosen_contacts_path].nil? ? "solutions" : params[:chosen_contacts_path].downcase
        
        if chosen_contacts_path == "solutions"
            @contacts_banner_image_url = Resource.find_by(name:"Contacts Banner - Solution Sales").attachment.url
        else
            @contacts_banner_image_url = Resource.find_by(name:"Contacts Banner - Channel Sales").attachment.url
        end
        
        @contact_nav_list = get_contacts_nav_list(chosen_contacts_path)
        
        slugs = get_contact_slugs
        page_title_for_slug = slugs.map{|item| item["slug"] == search_term ? item["pageTitle"] : nil}.compact[0]
        
        @contact_grouping_type = page_title_for_slug.nil? ? search_term.titlecase : page_title_for_slug
        @contact_sales_type = chosen_contacts_path.titlecase.singularize + " Sales"
        
        contacts = get_contacts
        @contacts = { contacts: [], unique_groups: []}
        contacts.each do |contact|
            
            group1 = contact["group1"]&.downcase.to_s
            group2 = contact["group2"]&.downcase.to_s
            group3 = contact["group3"]&.downcase.to_s
            group4 = contact["group4"]&.downcase.to_s
            
            territory_keys = (1..15).map{|num| "t#{num}"}
            
            contact_territory_values = territory_keys.map{|key| contact["#{key}"] }.compact.map!(&:downcase)
            
            @contacts[:unique_groups] << group1 unless @contacts[:unique_groups].include?(group1)
            @contacts[:unique_groups] << group2 unless @contacts[:unique_groups].include?(group2)
            @contacts[:unique_groups] << group3 unless @contacts[:unique_groups].include?(group3)
            @contacts[:unique_groups] << group4 unless @contacts[:unique_groups].include?(group4)
            
           if (contact_territory_values.include?(search_term) or group1&.include?(search_term) or group2&.include?(search_term) or group3&.include?(search_term) or group4&.include?(search_term))
             if chosen_contacts_path == "channel" && contact["channelMap"].downcase == "yes"
               @contacts[:contacts] << contact
             elsif chosen_contacts_path == "solutions" && contact["solutionsMap"].downcase == "yes"
               @contacts[:contacts] << contact
             end
           end  #  if (contact_territory_values.include?(search_term) or group1&.include?(search_term) or group2&.include?(search_term) or group3&.include?(search_term))
        end  #  contacts.each do |contact|
        
        # sort the contacts based on g1Sort value before returning
        @contacts[:contacts].sort_by! {|contact| contact["g1Sort"].nil? ? 100 : contact["g1Sort"] }
        
    end  #  def show
    
    def show_new
        search_term = params[:search].downcase
        chosen_contacts_path = params[:chosen_contacts_path].nil? ? "solutions" : params[:chosen_contacts_path].downcase
        
        if chosen_contacts_path == "solutions"
            @contacts_banner_image_url = Resource.find_by(name:"Contacts Banner - Solution Sales").attachment.url
        else
            @contacts_banner_image_url = Resource.find_by(name:"Contacts Banner - Channel Sales").attachment.url
        end
        
        @contact_nav_list = get_contacts_nav_list(chosen_contacts_path)
        
        slugs = get_contact_slugs
        page_title_for_slug = slugs.map{|item| item["slug"] == search_term ? item["pageTitle"] : nil}.compact[0]
        
        @contact_grouping_type = page_title_for_slug.nil? ? search_term.titlecase : page_title_for_slug
        @contact_sales_type = chosen_contacts_path.titlecase.singularize + " Sales"  
        
        contacts = get_contacts_new(search_term, chosen_contacts_path)
        @contacts = contacts
        # @contacts = { contacts: [], unique_groups: []}
        
    end  #  def show_new
    
    private
    
    def get_contacts
        contacts = Contacts.get_all_contacts
        contacts = contacts.select {|contact| 
            begin
                contact["showonweb"].downcase == "yes" 
            rescue
                # puts (contact["name"] + " missing showonweb attribute").colorize(:color => :light_blue, :background => :red)
            end
        }
        contacts
    end 
    
    def get_contacts_new(search_term, chosen_contacts_path)
        showforsolutions = (chosen_contacts_path == "solutions") ? 1 : 0
        showforchannels = (chosen_contacts_path == "channel") ? 1 : 0
        order_by = (chosen_contacts_path == "solutions") ? "contact_info_contact_team_groups.position" : "contact_info_contact_territories.position"
        contacts = ContactInfo::Contact.joins(:data_clients, :team_groups, :territories, :pro_site_options)
            .where("contact_info_contact_pro_site_options.showonweb = 1                     
                    and showforsolutions = #{showforsolutions}
                    and showforchannels = #{showforchannels}
                    and (contact_info_team_groups.name like ? or contact_info_territories.name like ?)
                    and contact_info_data_clients.name = ?",
                    "%#{search_term}%", 
                    "%#{search_term}%",
                    "pro.harman.com/contacts").order("#{order_by}").uniq
        contacts
    end  #  def get_contacts_new(search_term, chosen_contacts_path)

    def get_contact_slugs
        contact_slugs = Contacts.get_all_contact_slugs
        contact_slugs
    end

    def get_contacts_nav_list(contact_type="solution")
        contacts_nav_list = Contacts.get_all_contact_nav_list
        contacts_nav_list = contacts_nav_list.select {|item| item["type"].downcase == contact_type.singularize}
    end

end
