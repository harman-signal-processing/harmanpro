require "csv"
namespace :tse do

  # :nodoc:
  desc "Import Harman Technical Service Experts"
  task import: :environment do
    #puts "This task was already run. It should not be run again. The end."
    import_the_csv
  end

  def import_the_csv
    #TseCategory.delete_all
    TseCategoryContact.delete_all
    TseContact.delete_all
    TseContactRegion.delete_all
    TseContactTechnology.delete_all
    TseContactDomain.delete_all
    #TseRegion.delete_all
    #TseTechnology.delete_all
    #TseDomain.delete_all

    file = Rails.root.join("db", "tse.csv")

    CSV.open(file, 'r:ISO-8859-1', headers: true).each do |row|
      data = row.to_h
      next if data['FIRST'].blank?

      contact = TseContact.create!(
        name: "#{data['FIRST']} #{data['LAST']}",
        email: data['EMAIL'],
        phone: data['PHONE'],
        job_title: data['TITLE'],
        company: data['COMPANY'],
        address: data['ADDRESS'],
        manager: data['MANAGER']
      )
      puts "Created contact: #{contact.name}"

      parent = TseCategory.where(name: data["NAV1"]).first_or_create
      if data["NAV2"].present? && data["NAV2"] != "NULL"
        child = TseCategory.where(name: data["NAV2"], parent_id: parent.id).first_or_create
        child.tse_contacts << contact
      else
        parent.tse_contacts << contact
      end
      puts "  Added to navs"

      data.keys.each do |k|
        if k.to_s.match(/^T\_(.*)/)
          tech = TseTechnology.where(name: $1).first_or_create
          if data[k].to_i > 0
            TseContactTechnology.create(
              tse_contact: contact,
              tse_technology: tech,
              rank: data[k].to_i
            )
          end
        elsif k.to_s.match(/^D\_(.*)/)
          domain = TseDomain.where(name: $1).first_or_create
          if data[k].to_i > 0
            TseContactDomain.create(
              tse_contact: contact,
              tse_domain: domain,
              rank: data[k].to_i
            )
          end
        elsif k.to_s.match(/^R\_(.*)/)
          region = TseRegion.where(name: $1).first_or_create
          if data[k].to_i > 0
            TseContactRegion.create(
              tse_contact: contact,
              tse_region: region,
              rank: data[k].to_i
            )
          end
        end
      end
      puts "  Added to T,D,R"

    end

  end
  # :nodoc:
end
