require 'json'
namespace 'contact_info' do
  
  task :default => [:list_contacts]
  
  desc 'Read and list data from public/contacts.json'
  task :list_contacts do
    
    contacts_file = "#{Rails.root}/public/contacts.json"
    # puts "#{Rails.root}/public/contacts.json"
    # puts File.join(Rails.root,'public/contacts.json')
    # puts "yep i see the file" unless !File.exists? contacts_file
    # if File.exists? contacts_file
    #   JSON.parse(contacts_file)[""]
    # end
    
    contacts_file_content = File.read(contacts_file)
    contacts = JSON.parse(contacts_file_content)
    
    contacts.each do |contact|
      name = contact["name"]
      title = contact["title"]
      email = contact["email"]
      phones = [] << contact["phone1"] unless contact["phone1"].nil?
      phones << contact["phone2"] unless contact["phone2"].nil?
      groups = [] << contact["group1"]
      groups << contact["group2"] unless contact["group2"].nil?
      groups << contact["group3"] unless contact["group3"].nil?
      group_positions = [] << contact["g1Sort"] unless contact["g1Sort"].nil?
      group_positions << contact["g2Sort"] unless contact["g2Sort"].nil?
      group_positions << contact["g3Sort"] unless contact["g3Sort"].nil?
      # territories = [] << contact["t1"]
      territory_keys = (1..15).map{|num| "t#{num}"}
      contact_territory_values = territory_keys.map{|key| contact["#{key}"] }.compact.map!(&:downcase)
      showonweb = contact["showonweb"] == "yes" ? 1 : 0
      showforsolutions = contact["solutionsMap"] == "yes" ? 1 : 0
      showforchannels = contact["channelMap"] == "yes" ? 1 : 0
      
      
      
      
    binding.pry if showonweb == 1
    
      
    end
    
    
  end
  
end