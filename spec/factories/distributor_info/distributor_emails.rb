FactoryBot.define do
  factory :distributor_info_distributor_email, class: 'DistributorInfo::DistributorEmail' do
    association :distributor, factory: :distributor_info_distributor
    association :email, factory: :contact_info_email
    position { 1 }
  end
end
