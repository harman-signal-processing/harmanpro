FactoryBot.define do
  factory :contact_info_tag, class: 'ContactInfo::Tag' do
    sequence(:name) {|n| "Tag #{n}"}
  end
end
