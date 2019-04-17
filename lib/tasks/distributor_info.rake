require 'json'

namespace 'distributor_info' do
  
  task :default => [:add_brand_site_distributors_to_db]
  
  desc 'Read json data from [brandsite]/distributors.json and parse and save to db'
  task :add_brand_site_distributors_to_db => :environment do
    
    brandsiteurl = "https://www.amx.com/en-US/distributors.json"
    response = HTTParty.get(brandsiteurl, format: :plain)
    if response.success?
      distributors = JSON.parse response, symbolize_names: true
    else
      distributors = []
      raise response.message
    end
    
    distributors.each do |dist|
      name = dist[:name].strip
      details = dist[:detail].split("<br />")
      emails = dist[:detail].split("mailto:")
      country = dist[:country]
      email = dist[:email]
      account_number = dist[:account_number]
    end
    
  end  #  task :add_brand_site_distributors_to_db => :environment do
  
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
  
  
end  #  namespace 'distributor_info' do