require 'country_select'
namespace 'country_info' do
  task :default => [:add_country_info_to_db]
  
    task :add_country_info_to_db => :environment do
      
      ISO3166::Data.cache.each do |item|
        country = LocationInfo::Country.new
  
        puts item[1]["name"] #name
        country.name = item[1]["name"]
        
        #harman_name
        country.harman_name = item[1]["name"]
        
        puts item[1]["alpha2"] #alpha2
        country.alpha2 = item[1]["alpha2"]
        
        puts item[1]["alpha3"] #alpha3
        country.alpha3 = item[1]["alpha3"]
        
        puts item[1]["continent"] #continent
        country.continent = item[1]["continent"]
        
        puts item[1]["region"] #region
        country.region = item[1]["region"]
        
        puts item[1]["subregion"] #sub_region
        country.sub_region = item[1]["subregion"]
        
        puts item[1]["world_region"] #world_region
        country.world_region = item[1]["world_region"]
        
        #harman_world_region
        country.harman_world_region = item[1]["world_region"]
        
        puts item[1]["country_code"] #calling_code
        country.calling_code = item[1]["country_code"]
        
        puts item[1]["number"] #numeric_code
        country.numeric_code = item[1]["number"]
        
        country.save
        
        puts "------------------"
        
      end
    end
  
end  #  namespace 'country_info' do