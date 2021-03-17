require 'csv'
namespace :lead_routing do

  desc "Import lead recipients"
  task import_country_recipients: :environment do
    file = Rails.root.join("db", "lead_routing_by_country.csv")

    CSV.open(file, 'r:ISO-8859-1', headers: true).each do |row|
      data = row.to_h

      country = ISO3166::Country.find_country_by_name(data['country'])

      if country
        puts "Country found: #{data['country']} -> #{ country.alpha2 }"
        if data['recip_1'].present?
          CountryLeadRecipient.where(country: country.alpha2, user_id: data['recip_1']).first_or_create!
        end
        if data['recip_2'].present?
          CountryLeadRecipient.where(country: country.alpha2, user_id: data['recip_2']).first_or_create!
        end
        if data['recip_3'].present?
          CountryLeadRecipient.where(country: country.alpha2, user_id: data['recip_3']).first_or_create!
        end
      else
        puts "-------------> ERROR FINDING #{data['country']} <---------------"
      end
    end
  end
end
