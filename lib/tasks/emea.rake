namespace :emea do

  desc "Seed the channel manager database"
  task :seed_channel_management => :environment do

    ChannelCountryManager.delete_all
    Channel.delete_all
    ChannelManager.delete_all
    ChannelCountry.delete_all

    channel_country_managers = [
      ["Pro Audio", "Albania", "Mark Coombes"],
      ["Pro Lighting", "Albania", "Peter Dahlin"],
      ["AV & Control", "Albania", "Mark Coombes"],
      ["Broadcast", "Albania", "Graham Murray"],
      ["Retail Lighting", "Albania", "Mark Coombes"],

      ["Pro Audio", "Algeria", "Thomas Delory"],
      ["Pro Lighting", "Algeria", "Thomas Delory"],
      ["AV & Control", "Algeria", "Thomas Delory"],
      ["Broadcast", "Algeria", "Graham Murray"],
      ["Retail Lighting", "Algeria", "Thomas Delory"],

      ["Pro Audio", "Austria", "Alex Lindner"],
      ["Pro Lighting", "Austria", "Henning Oeker"],
      ["AV & Control", "Austria", "Alex Lindner"],
      ["Broadcast", "Austria", "Tibor Tamas"],
      ["Retail Lighting", "Austria", "Alex Lindner"],

      ["Pro Audio", "Bahrain", "Mark Coombes"],
      ["Pro Lighting", "Bahrain", "Mark Coombes"],
      ["AV & Control", "Bahrain", "Mark Coombes"],
      ["Broadcast", "Bahrain", "Graham Murray"],
      ["Retail Lighting", "Bahrain", "Mark Coombes"],

      ["Pro Audio", "Balkans", "Mark Coombes"],
      ["Pro Lighting", "Balkans", "Peter Dahlin"],
      ["AV & Control", "Balkans", "Mark Coombes"],
      ["Broadcast", "Balkans", "Karl Chapman"],
      ["Retail Lighting", "Balkans", "Mark Coombes"],

      ["Pro Audio", "Belgium", "Philippe Poppe"],
      ["Pro Lighting", "Belgium", "Philippe Poppe"],
      ["AV & Control", "Belgium", "Philippe Poppe"],
      ["Broadcast", "Belgium", "Karl Chapman"],
      ["Retail Lighting", "Belgium", "Philippe Poppe"],

      ["Pro Audio", "Bulgaria", "Mark Coombes"],
      ["Pro Lighting", "Bulgaria", "Peter Dahlin"],
      ["AV & Control", "Bulgaria", "Mark Coombes"],
      ["Broadcast", "Bulgaria", "Graham Murray"],
      ["Retail Lighting", "Bulgaria", "Mark Coombes"],

      ["Pro Audio", "Central Africa", "Richard Ayres"],
      ["Pro Lighting", "Central Africa", "Peter Dahlin"],
      ["AV & Control", "Central Africa", "Richard Ayres"],
      ["Broadcast", "Central Africa", "Graham Murray"],
      ["Retail Lighting", "Central Africa", "Richard Ayres"],

      ["Pro Audio", "Croatia", "Mark Coombes"],
      ["Pro Lighting", "Croatia", "Peter Dahlin"],
      ["AV & Control", "Croatia", "Mark Coombes"],
      ["Broadcast", "Croatia", "Karl Chapman"],
      ["Retail Lighting", "Croatia", "Mark Coombes"],

      ["Pro Audio", "Cyprus", "Richard Ayres"],
      ["Pro Lighting", "Cyprus", "Peter Dahlin"],
      ["AV & Control", "Cyprus", "Richard Ayres"],
      ["Broadcast", "Cyprus", "Karl Chapman"],
      ["Retail Lighting", "Cyprus", "Richard Ayres"],

      ["Pro Audio", "Czech Rep", "Radko Mach"],
      ["Pro Lighting", "Czech Rep", "Peter Dahlin"],
      ["AV & Control", "Czech Rep", "Radko Mach"],
      ["Broadcast", "Czech Rep", "Karl Chapman"],
      ["Retail Lighting", "Czech Rep", "Radko Mach"],

      ["Pro Audio", "Denmark", "Fredrik Barno"],
      ["Pro Lighting", "Denmark", "Direct"],
      ["AV & Control", "Denmark", "Fredrik Barno"],
      ["Broadcast", "Denmark", "Graham Murray"],
      ["Retail Lighting", "Denmark", "Fredrik Barno"],

      ["Pro Audio", "Egypt", "Dave Budge"],
      ["Pro Lighting", "Egypt", "Mark Coombes"],
      ["AV & Control", "Egypt", "Mark Coombes"],
      ["Broadcast", "Egypt", "Graham Murray"],
      ["Retail Lighting", "Egypt", "Dave Budge"],

      ["Pro Audio", "Estonia", "Mark Coombes"],
      ["Pro Lighting", "Estonia", "Peter Dahlin"],
      ["AV & Control", "Estonia", "Mark Coombes"],
      ["Broadcast", "Estonia", "Karl Chapman"],
      ["Retail Lighting", "Estonia", "Mark Coombes"],

      ["Pro Audio", "Finland", "Fredrik Barno"],
      ["Pro Lighting", "Finland", "Direct"],
      ["AV & Control", "Finland", "Fredrik Barno"],
      ["Broadcast", "Finland", "Graham Murray"],
      ["Retail Lighting", "Finland", "Fredrik Barno"],

      ["Pro Audio", "France", "Thomas Delory"],
      ["Pro Lighting", "France", "Thomas Delory"],
      ["AV & Control", "France", "Thomas Delory"],
      ["Broadcast", "France", "Karl Chapman"],
      ["Retail Lighting", "France", "Thomas Delory"],

      ["Pro Audio", "Germany", "Aljoscha Bergforth"],
      ["Pro Lighting", "Germany", "Henning Oeker"],
      ["AV & Control", "Germany", "Direct"],
      ["Broadcast", "Germany", "Tibor Tamas"],
      ["Retail Lighting", "Germany", "Aljoscha Bergforth"],

      ["Pro Audio", "Greece", "Richard Ayres"],
      ["Pro Lighting", "Greece", "Peter Dahlin"],
      ["AV & Control", "Greece", "Richard Ayres"],
      ["Broadcast", "Greece", "Karl Chapman"],
      ["Retail Lighting", "Greece", "Richard Ayres"],

      ["Pro Audio", "Hungary", "Radko Mach"],
      ["Pro Lighting", "Hungary", "Peter Dahlin"],
      ["AV & Control", "Hungary", "Radko Mach"],
      ["Broadcast", "Hungary", "Karl Chapman"],
      ["Retail Lighting", "Hungary", "Radko Mach"],

      ["Pro Audio", "Iceland", "Fredrik Barno"],
      ["Pro Lighting", "Iceland", "Direct"],
      ["AV & Control", "Iceland", "Fredrik Barno"],
      ["Broadcast", "Iceland", "Graham Murray"],
      ["Retail Lighting", "Iceland", "Fredrik Barno"],

      ["Pro Audio", "Iraq", "Mark Coombes"],
      ["Pro Lighting", "Iraq", "Mark Coombes"],
      ["AV & Control", "Iraq", "Mark Coombes"],
      ["Broadcast", "Iraq", "Graham Murray"],
      ["Retail Lighting", "Iraq", "Mark Coombes"],

      ["Pro Audio", "Israel", "Dave Budge"],
      ["Pro Lighting", "Israel", "Peter Dahlin"],
      ["AV & Control", "Israel", "Dave Budge"],
      ["Broadcast", "Israel", "Graham Murray"],
      ["Retail Lighting", "Israel", "Dave Budge"],

      ["Pro Audio", "Italy", "Dave Budge"],
      ["Pro Lighting", "Italy", "Dave Budge"],
      ["AV & Control", "Italy", "Dave Budge"],
      ["Broadcast", "Italy", "Karl Chapman"],
      ["Retail Lighting", "Italy", "Dave Budge"],

      ["Pro Audio", "Jordan", "Mark Coombes"],
      ["Pro Lighting", "Jordan", "Mark Coombes"],
      ["AV & Control", "Jordan", "Mark Coombes"],
      ["Broadcast", "Jordan", "Graham Murray"],
      ["Retail Lighting", "Jordan", "Mark Coombes"],

      ["Pro Audio", "Kuwait", "Mark Coombes"],
      ["Pro Lighting", "Kuwait", "Mark Coombes"],
      ["AV & Control", "Kuwait", "Mark Coombes"],
      ["Broadcast", "Kuwait", "Graham Murray"],
      ["Retail Lighting", "Kuwait", "Mark Coombes"],

      ["Pro Audio", "Latvia", "Mark Coombes"],
      ["Pro Lighting", "Latvia", "Peter Dahlin"],
      ["AV & Control", "Latvia", "Mark Coombes"],
      ["Broadcast", "Latvia", "Karl Chapman"],
      ["Retail Lighting", "Latvia", "Mark Coombes"],

      ["Pro Audio", "Lebanon", "Dave Budge"],
      ["Pro Lighting", "Lebanon", "Mark Coombes"],
      ["AV & Control", "Lebanon", "Mark Coombes"],
      ["Broadcast", "Lebanon", "Graham Murray"],
      ["Retail Lighting", "Lebanon", "Dave Budge"],

      ["Pro Audio", "Libya", "Richard Ayres"],
      ["Pro Lighting", "Libya", "Peter Dahlin"],
      ["AV & Control", "Libya", "Richard Ayres"],
      ["Broadcast", "Libya", "Graham Murray"],
      ["Retail Lighting", "Libya", "Richard Ayres"],

      ["Pro Audio", "Lithuania", "Mark Coombes"],
      ["Pro Lighting", "Lithuania", "Peter Dahlin"],
      ["AV & Control", "Lithuania", "Mark Coombes"],
      ["Broadcast", "Lithuania", "Karl Chapman"],
      ["Retail Lighting", "Lithuania", "Mark Coombes"],

      ["Pro Audio", "Luxembourg", "Philippe Poppe"],
      ["Pro Lighting", "Luxembourg", "Philippe Poppe"],
      ["AV & Control", "Luxembourg", "Philippe Poppe"],
      ["Broadcast", "Luxembourg", "Karl Chapman"],
      ["Retail Lighting", "Luxembourg", "Philippe Poppe"],

      ["Pro Audio", "Malta", "Richard Ayres"],
      ["Pro Lighting", "Malta", "Peter Dahlin"],
      ["AV & Control", "Malta", "Richard Ayres"],
      ["Broadcast", "Malta", "Karl Chapman"],
      ["Retail Lighting", "Malta", "Richard Ayres"],

      ["Pro Audio", "Morocco", "Thomas Delory"],
      ["Pro Lighting", "Morocco", "Thomas Delory"],
      ["AV & Control", "Morocco", "Thomas Delory"],
      ["Broadcast", "Morocco", "Graham Murray"],
      ["Retail Lighting", "Morocco", "Thomas Delory"],

      ["Pro Audio", "Netherlands", "Philippe Poppe"],
      ["Pro Lighting", "Netherlands", "Philippe Poppe"],
      ["AV & Control", "Netherlands", "Philippe Poppe"],
      ["Broadcast", "Netherlands", "Karl Chapman"],
      ["Retail Lighting", "Netherlands", "Philippe Poppe"],

      ["Pro Audio", "N. Cyprus", "Richard Ayres"],
      ["Pro Lighting", "N. Cyprus", "Peter Dahlin"],
      ["AV & Control", "N. Cyprus", "Richard Ayres"],
      ["Broadcast", "N. Cyprus", "Karl Chapman"],
      ["Retail Lighting", "N. Cyprus", "Richard Ayres"],

      ["Pro Audio", "Norway", "Fredrik Barno"],
      ["Pro Lighting", "Norway", "Direct"],
      ["AV & Control", "Norway", "Fredrik Barno"],
      ["Broadcast", "Norway", "Graham Murray"],
      ["Retail Lighting", "Norway", "Fredrik Barno"],

      ["Pro Audio", "Oman", "Mark Coombes"],
      ["Pro Lighting", "Oman", "Mark Coombes"],
      ["AV & Control", "Oman", "Mark Coombes"],
      ["Broadcast", "Oman", "Graham Murray"],
      ["Retail Lighting", "Oman", "Mark Coombes"],

      ["Pro Audio", "Poland", "Przemyslaw Kolasa"],
      ["Pro Lighting", "Poland", "Peter Dahlin"],
      ["AV & Control", "Poland", "Przemyslaw Kolasa"],
      ["Broadcast", "Poland", "Tibor Tamas"],
      ["Retail Lighting", "Poland", "Przemyslaw Kolasa"],

      ["Pro Audio", "Portugal", "Richard Ayres"],
      ["Pro Lighting", "Portugal", "Peter Dahlin"],
      ["AV & Control", "Portugal", "Richard Ayres"],
      ["Broadcast", "Portugal", "Karl Chapman"],
      ["Retail Lighting", "Portugal", "Richard Ayres"],

      ["Pro Audio", "Qatar", "Mark Coombes"],
      ["Pro Lighting", "Qatar", "Mark Coombes"],
      ["AV & Control", "Qatar", "Mark Coombes"],
      ["Broadcast", "Qatar", "Graham Murray"],
      ["Retail Lighting", "Qatar", "Mark Coombes"],

      ["Pro Audio", "Republic of Ireland", "Scott Aslett"],
      ["Pro Lighting", "Republic of Ireland", "Direct"],
      ["AV & Control", "Republic of Ireland", "Scott Aslett"],
      ["Broadcast", "Republic of Ireland", "Karl Chapman"],
      ["Retail Lighting", "Republic of Ireland", "Scott Aslett"],

      ["Pro Audio", "Romania", "Radko Mach"],
      ["Pro Lighting", "Romania", "Peter Dahlin"],
      ["AV & Control", "Romania", "Radko Mach"],
      ["Broadcast", "Romania", "Graham Murray"],
      ["Retail Lighting", "Romania", "Radko Mach"],

      ["Pro Audio", "Saudi Arabia", "Mark Coombes"],
      ["Pro Lighting", "Saudi Arabia", "Mark Coombes"],
      ["AV & Control", "Saudi Arabia", "Mark Coombes"],
      ["Broadcast", "Saudi Arabia", "Graham Murray"],
      ["Retail Lighting", "Saudi Arabia", "Mark Coombes"],

      ["Pro Audio", "Serbia & Montenegro", "Mark Coombes"],
      ["Pro Lighting", "Serbia & Montenegro", "Peter Dahlin"],
      ["AV & Control", "Serbia & Montenegro", "Mark Coombes"],
      ["Broadcast", "Serbia & Montenegro", "Karl Chapman"],
      ["Retail Lighting", "Serbia & Montenegro", "Mark Coombes"],

      ["Pro Audio", "Slovakia", "Radko Mach"],
      ["Pro Lighting", "Slovakia", "Peter Dahlin"],
      ["AV & Control", "Slovakia", "Radko Mach"],
      ["Broadcast", "Slovakia", "Karl Chapman"],
      ["Retail Lighting", "Slovakia", "Radko Mach"],

      ["Pro Audio", "South Africa", "Dave Budge"],
      ["Pro Lighting", "South Africa", "Peter Dahlin"],
      ["AV & Control", "South Africa", "Dave Budge"],
      ["Broadcast", "South Africa", "Graham Murray"],
      ["Retail Lighting", "South Africa", "Dave Budge"],

      ["Pro Audio", "Spain", "Richard Ayres"],
      ["Pro Lighting", "Spain", "Peter Dahlin"],
      ["AV & Control", "Spain", "Richard Ayres"],
      ["Broadcast", "Spain", "Karl Chapman"],
      ["Retail Lighting", "Spain", "Richard Ayres"],

      ["Pro Audio", "Sweden", "Fredrik Barno"],
      ["Pro Lighting", "Sweden", "Direct"],
      ["AV & Control", "Sweden", "Fredrik Barno"],
      ["Broadcast", "Sweden", "Graham Murray"],
      ["Retail Lighting", "Sweden", "Fredrik Barno"],

      ["Pro Audio", "Switzerland", "Felix Gittinger"],
      ["Pro Lighting", "Switzerland", "Felix Gittinger"],
      ["AV & Control", "Switzerland", "Felix Gittinger"],
      ["Broadcast", "Switzerland", "Tibor Tamas"],
      ["Retail Lighting", "Switzerland", "Felix Gittinger"],

      ["Pro Audio", "Tunisia", "Thomas Delory"],
      ["Pro Lighting", "Tunisia", "Thomas Delory"],
      ["AV & Control", "Tunisia", "Thomas Delory"],
      ["Broadcast", "Tunisia", "Graham Murray"],
      ["Retail Lighting", "Tunisia", "Thomas Delory"],

      ["Pro Audio", "Turkey", "Dave Budge"],
      ["Pro Lighting", "Turkey", "Dave Budge"],
      ["AV & Control", "Turkey", "Dave Budge"],
      ["Broadcast", "Turkey", "Karl Chapman"],
      ["Retail Lighting", "Turkey", "Dave Budge"],

      ["Pro Audio", "UAE", "Mark Coombes"],
      ["Pro Lighting", "UAE", "Mark Coombes"],
      ["AV & Control", "UAE", "Mark Coombes"],
      ["Broadcast", "UAE", "Graham Murray"],
      ["Retail Lighting", "UAE", "Mark Coombes"],

      ["Pro Audio", "UK", "Scott Aslett"],
      ["Pro Lighting", "UK", "Direct"],
      ["AV & Control", "UK", "Scott Aslett"],
      ["Broadcast", "UK", "Karl Chapman"],
      ["Retail Lighting", "UK", "Scott Aslett"]

    ]

    channel_country_managers.each do |ccm|
      puts "Creating: #{ ccm.inspect }"
      ChannelCountryManager.create!(
        channel: Channel.where(name: ccm[0]).first_or_create,
        channel_country: ChannelCountry.where(name: ccm[1]).first_or_create,
        channel_manager: ChannelManager.where(name: ccm[2]).first_or_create
      )
    end

    ChannelCountry.all.each do |channel_country|
      ChannelCountryManager.create!(
        channel_country: channel_country,
        channel_manager: ChannelManager.where(name: "Dave Karlsen").first_or_create,
        channel: Channel.where(name: "DigiTech").first_or_create
      )
    end

    ChannelManager.all.each do |cm|
      if cm.email.blank?
        names = cm.name.split(/\s/)
        if names.length > 1
          cm.update_column(:email, "#{ names.join(".").downcase }@harman.com")
        end
      end
    end
  end

end
