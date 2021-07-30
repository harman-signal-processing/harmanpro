require 'csv'
namespace :media_coverage do

  desc "Import pre-existing media coverage"
  task import: :environment do
    BrandMediaCoverage.delete_all
    MediaCoverage.delete_all
    MediaOutlet.delete_all

    file = Rails.root.join("db", "media_coverage.csv")
    import_media_coverage(file)
  end

  desc "Import media coverage without deleting old stuff"
  task import_without_delete: :environment do
    file = Rails.root.join("db", "media_coverage.csv")
    import_media_coverage(file)
  end

  private

  def import_media_coverage(file)
    jbl_professional = Brand.find("jbl-professional")
    martin = Brand.find("martin")
    amx = Brand.find("amx")
    akg = Brand.find("akg")
    crown = Brand.find("crown")
    soundcraft = Brand.find("soundcraft")
    studer = Brand.find("studer")
    bss = Brand.find("bss")
    dbx = Brand.find("dbx")
    digitech = Brand.find("digitech")
    lexicon = Brand.find("lexicon")

    CSV.open(file, 'r:ISO-8859-1', headers: true).each_with_index do |row, i|
      puts "Row #{i} - #{row['News Date']}"
      data = row.to_h

      next if data['Link'].blank?
      next unless data['Link'].to_s.match(/http/)
      next if data['News Date'].blank?
      #next if data['News Date'].to_date < "2021-01-01".to_date

      media_outlet_name = data['Outlet Name'].strip
      outlets = MediaOutlet.where("UPPER(name) = ?", media_outlet_name.upcase)
      if outlets.length > 0
        media_outlet = outlets.first
      else
        media_outlet = MediaOutlet.where(name: media_outlet_name).first_or_create!
      end

      media_coverage = MediaCoverage.where(
        media_outlet_id: media_outlet.id,
        news_date: data['News Date'].to_date,
        headline: cleaned_up_headline(data['News Headline']),
        media_type: data['Type'],
        syndicated: !!(data['Syndicated'].to_s.match?(/Yes|X/i)),
        media_length: data['Length'],
        case_study: !!(data['Case Study'].to_s.match?(/Yes|X/i)),
        initiative: data['Initiative'],
        region: data['Region'],
        link: data['Link']
      ).first_or_create!

      if data['JBL'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: jbl_professional).first_or_create!
      end

      if data['Martin'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: martin).first_or_create!
      end

      if data['AMX'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: amx).first_or_create!
      end

      if data['AKG'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: akg).first_or_create!
      end

      if data['Crown'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: crown).first_or_create!
      end

      if data['Soundcraft'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: soundcraft).first_or_create!
      end

      if data['Studer'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: studer).first_or_create!
      end

      if data['BSS'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: bss).first_or_create!
      end

      if data['dbx'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: dbx).first_or_create!
      end

      if data['DigiTech'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: digitech).first_or_create!
      end

      if data['Lexicon'].present?
        BrandMediaCoverage.where(media_coverage: media_coverage, brand: lexicon).first_or_create!
      end

      media_coverage.reload

      # if coverage was only for Studer, then let's delete the coverage
      if media_coverage.brands == [studer]
        media_coverage.destroy
      end
    end

    # Clean up any remaining Studer coverage
    BrandMediaCoverage.where(brand: studer).destroy_all
  end

  def cleaned_up_headline(headline)
    headline = headline.titleize
    headline = headline.gsub(/ûª/, "'")
    headline = headline.gsub(/ûò/, "–")
    headline = headline.gsub(/\"ó/, "–")
    headline = headline.gsub(/ûï/, '"')
    headline = headline.gsub(/û/, '"')
    headline = headline.gsub(/åê/, " ")
    headline = headline.titleize
    headline = headline.gsub(/harman/i, "HARMAN")
    headline = headline.gsub(/jbl/i, "JBL")
    headline = headline.gsub(/\beon/i, "EON")
    headline = headline.gsub(/eon one/i, "EON ONE")
    headline = headline.gsub(/irx/i, "IRX")
    headline = headline.gsub(/prx/i, "PRX")
    headline = headline.gsub(/vtx/i, "VTX")
    headline = headline.gsub(/cbt/i, "CBT")
    headline = headline.gsub(/akg/i, "AKG")
    headline = headline.gsub(/amx/i, "AMX")
    headline = headline.gsub(/dgx/i, "DGX")
    headline = headline.gsub(/dvx/i, "DVX")
    headline = headline.gsub(/bss/i, "BSS")
    headline = headline.gsub(/dbx/i, "dbx")
    headline = headline.gsub(/vdo/i, "VDO")
    headline = headline.gsub(/pxl/i, "PXL")
    headline = headline.gsub(/\bav\b/i, "AV")
    headline = headline.gsub(/\bdj\b/i, "DJ")
    headline = headline.gsub(/\bla$/i, "LA")
    headline = headline.gsub(/bbc/i, "BBC")
    headline = headline.gsub(/cnbc/i, "CNBC")
    headline = headline.gsub(/ldi/i, "LDI")
    headline = headline.gsub(/\bjcu\b/i, "JCU")
    headline = headline.gsub(/\bled\b/i, "LED")
    headline = headline.gsub(/\busb\b/i, "USB")
    headline = headline.gsub(/\bpa\b/i, "PA")
    headline = headline.gsub(/\bces\b/i, "CES")
    headline = headline.gsub(/\bhd/i, "HD")
    headline = headline.gsub(/\bbt/i, "BT")
    headline = headline.gsub(/namm/i, "NAMM")
    headline = headline.gsub(/avl/i, "AVL")
    headline = headline.gsub(/\bby\b/i, "by")
    headline = headline.gsub(/\bemea\b/i, "EMEA")
    headline = headline.gsub(/\bapac\b/i, "APAC")
    headline = headline.gsub(/Erì¤In/, "Erçin")
    headline
  end

end
