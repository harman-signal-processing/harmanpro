FactoryBot.define do
  factory :contact_info_phone, class: 'ContactInfo::Phone' do
    sequence(:phone) {|n| "123-456-78#{n}#{n}"}
  end
end
