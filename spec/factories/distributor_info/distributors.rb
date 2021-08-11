FactoryBot.define do
  factory :distributor_info_distributor, class: 'DistributorInfo::Distributor' do
    sequence(:name) {|n| "Distributor #{n}"}
    sequence(:account_number) {|n| "1234#{n}"}
  end
end
