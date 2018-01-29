class ContactsController < ApplicationController

    def index
       contacts = get_contacts
       @contacts = { contacts: contacts, unique_groups: []}
        # binding.pry
       @contacts
    end
    
    def show
        @landing_page = LandingPage.find("contactsmap")
        # binding.pry
        search_term = params[:search].downcase
        map_to_use = params[:map].nil? ? "solutions" : params[:map].downcase
        
        slugs = get_contact_slugs
        
        titleSlug = slugs.map{|item| item["slug"] == search_term ? item["pageTitle"] : nil}.compact[0]
        
        @pageTitle = titleSlug.nil? ? search_term.titlecase : titleSlug
        @contactType = map_to_use.titlecase + " Sales"
        # binding.pry
        
        contacts = get_contacts
        @contacts = { contacts: [], unique_groups: []}
        contacts.each do |contact|
            group1 = contact["group1"]&.downcase.to_s
            group2 = contact["group2"]&.downcase.to_s
            group3 = contact["group3"]&.downcase.to_s
            
            territory_keys = (1..15).map{|num| "t#{num}"}
            
            
            
            contact_territory_values = territory_keys.map{|key| contact["#{key}"] }.compact.map!(&:downcase)
            
            
            
            # group1Sort = contact["g1Sort"].to_i
            # group2Sort = contact["g2Sort"].to_i
            # group3Sort = contact["g3Sort"].to_i
            
            @contacts[:unique_groups] << group1 unless @contacts[:unique_groups].include?(group1)
            @contacts[:unique_groups] << group2 unless @contacts[:unique_groups].include?(group2)
            @contacts[:unique_groups] << group3 unless @contacts[:unique_groups].include?(group3)
            
        # binding.pry
           if (contact_territory_values.include?(search_term) or group1&.include?(search_term) or group2&.include?(search_term) or group3&.include?(search_term))
             if map_to_use == "channel" && contact["channelMap"].downcase == "yes"
               @contacts[:contacts] << contact
             elsif map_to_use == "solutions" && contact["solutionsMap"].downcase == "yes"
               @contacts[:contacts] << contact
             end
           else
               # do nothing
           end  #  group1&.include?(searchTerm) or group2&.include?(searchTerm) or group3&.include?(searchTerm)
        end  #  contacts.each do |contact|
        
    end  #  def show
    
    def most_popular
        # binding.pry
       @contacts = get_contacts
       
       puts "most_popular called" 
       render action: :index and return false
    end
    
    private
    
    def get_contacts
        contacts = Contacts.get_all_contacts
        contacts = contacts.select {|contact| contact["showonweb"].downcase == "yes"}
        contacts
    end 

    def get_contact_slugs
        contact_slugs = Contacts.get_all_contact_slugs
        contact_slugs
    end

end
