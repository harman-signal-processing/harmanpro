FactoryBot.define do
  factory :distributor_info_distributor_contact, class: 'DistributorInfo::DistributorContact' do
    association :distributor, factory: :distributor_info_distributor
    association :contact, factory: :contact_info_contact
    position { 1 }
  end
end
