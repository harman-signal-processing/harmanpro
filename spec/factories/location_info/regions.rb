FactoryBot.define do
  factory :location_info_region, class: 'LocationInfo::Region' do
    sequence(:name) {|n| "North America #{n}"}
  end
end
