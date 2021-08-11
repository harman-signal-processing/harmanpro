FactoryBot.define do
  factory :distributor_info_distributor_website, class: 'DistributorInfo::DistributorWebsite' do
    association :distributor, factory: :distributor_info_distributor
    association :website, factory: :contact_info_website
    position { 1 }
  end
end
