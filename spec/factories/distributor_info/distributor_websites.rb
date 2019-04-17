FactoryBot.define do
  factory :distributor_info_distributor_website, class: 'DistributorInfo::DistributorWebsite' do
    distributor { DistributorInfo::Distributor.create(name: 'Distributor 1') }
    website { ContactInfo::Website.create(url: 'https://pro.harman.com') }
    position { 1 }    
  end
end
