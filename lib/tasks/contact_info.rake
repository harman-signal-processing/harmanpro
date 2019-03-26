require 'json'
namespace 'contact_info' do
  
  task :default => [:add_prosite_contacts_to_db]

  desc 'Read data from public/contacts.json and save to db'
  task :add_prosite_contacts_to_db => :environment do
    
    contacts_file = "#{Rails.root}/public/contacts.json"
    # puts "#{Rails.root}/public/contacts.json"
    # puts File.join(Rails.root,'public/contacts.json')
    # puts "yep i see the file" unless !File.exists? contacts_file
    # if File.exists? contacts_file
    #   JSON.parse(contacts_file)[""]
    # end
    
    contacts_file_content = File.read(contacts_file)
    contacts = JSON.parse(contacts_file_content)
    
    #!!!CAREFUL MAKE SURE YOU WANT TO DELETE EVERYTHING!!!
    Rake::Task["contact_info:delete_everything"].invoke
    
    contacts.each do |contact|
      
      #create contact
      name = contact["name"]
      title = contact["title"]

      puts "Creating contact: #{name}"
      newcontact = ContactInfo::Contact.find_or_create_by({name: "#{name}"})
      newcontact.title = title unless title.blank?
      newcontact.save
      
      #set data client
      newcontact.data_clients << ContactInfo::DataClient.find_or_create_by({name:"pro.harman.com/contacts"})
      
      #create contact emails
      email = contact["email"]
      
      
      puts "Associating email:#{email} to contact:#{newcontact.name}" unless email.blank?
      newcontact.emails << ContactInfo::Email.create({email: "#{email}"}) unless email.blank?
      
      #create contact phones
      phones = [] 
      phones << contact["phone1"] unless contact["phone1"].blank?
      phones << contact["phone2"] unless contact["phone2"].blank?
      
      if !phones.nil?
        phones.each do |phone|
          puts "Creating and associating phone:#{phone} to contact:#{newcontact.name}"
          newcontact.phones << ContactInfo::Phone.find_or_create_by({phone: "#{phone}"})
        end
      end
      
      # #create contact team_groups
      groups = [] << contact["group1"]
      groups << contact["group2"] unless contact["group2"].blank?
      groups << contact["group3"] unless contact["group3"].blank?
      group_positions = [] << contact["g1Sort"] unless contact["g1Sort"].blank?
      group_positions << contact["g2Sort"] unless contact["g2Sort"].blank?
      group_positions << contact["g3Sort"] unless contact["g3Sort"].blank?      
      
      if !groups.nil?
        groups.each_with_index do |group, index|
          if !group.nil?
            team = ContactInfo::TeamGroup.find_or_create_by(name: "#{group}")

            puts "Associating team: #{team.name} with contact: #{newcontact.name}"
            newteamassociation = ContactInfo::ContactTeamGroup.find_or_create_by(contact_info_contact_id: "#{newcontact.id}", contact_info_team_group_id: "#{team.id}")

            group_position = group_positions[index] unless group_positions.blank?
            puts "Updating position for #{team.name}-#{newcontact.name} to #{group_position}" unless group_position.blank?
            newteamassociation.position = group_position unless group_position.blank?
            newteamassociation.save
          end
        end
      end
      
      #create contact territories
      territory_keys = (1..15).map{|num| "t#{num}"}
      contact_territory_values = territory_keys.map{|key| contact["#{key}"] }.compact.map!(&:downcase)
      
      if !contact_territory_values.nil?
        contact_territory_values.each do |territory|
          
          newterritory = ContactInfo::Territory.find_or_create_by(name:"#{territory}")
          puts "Associating territory:#{newterritory.name} with contact: #{newcontact.name}"
          ContactInfo::ContactTerritory.find_or_create_by(contact_info_contact_id: "#{newcontact.id}", contact_info_territory_id: "#{newterritory.id}")
        end
      end
      
      #create contact pro_site_options
      showonweb = contact["showonweb"] == "yes" ? 1 : 0
      showforsolutions = contact["solutionsMap"] == "yes" ? 1 : 0
      showforchannels = contact["channelMap"] == "yes" ? 1 : 0      
      prositeoption = ContactInfo::ContactProSiteOption.find_or_create_by(contact_info_contact_id:"#{newcontact.id}")
      # binding.pry if newcontact.name == "Paul Gessler"
      prositeoption.showonweb = showonweb
      prositeoption.showforsolutions = showforsolutions
      prositeoption.showforchannels = showforchannels
      prositeoption.save
      
    # binding.pry if showonweb == 1
    
      
    end  #  contacts.each do |contact|
    
    
  end  #  task :add_prosite_contacts_to_db => :environment do
  
  desc 'Delete everything before adding new data. Just used for testing.'
  task :delete_everything => :environment do
    puts "Deleting all contact info!!!!!!!!!!"
    #Delete everything
    ContactInfo::ContactDataClient.delete_all
    ContactInfo::ContactEmail.delete_all
    ContactInfo::ContactPhone.delete_all
    ContactInfo::ContactProSiteOption.delete_all
    ContactInfo::ContactTag.delete_all
    ContactInfo::ContactTeamGroup.delete_all
    ContactInfo::ContactTerritory.delete_all
    ContactInfo::ContactWebsite.delete_all
    ContactInfo::Contact.delete_all
    ContactInfo::DataClient.delete_all
    ContactInfo::Email.delete_all
    ContactInfo::Phone.delete_all
    ContactInfo::Tag.delete_all
    ContactInfo::TeamGroup.delete_all
    ContactInfo::Territory.delete_all
    ContactInfo::Website.delete_all    
  end  #  task :delete_everything => :environment do
  
end  # namespace 'contact_info' do