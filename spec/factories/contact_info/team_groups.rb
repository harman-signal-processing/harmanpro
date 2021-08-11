FactoryBot.define do
  factory :contact_info_team_group, class: 'ContactInfo::TeamGroup' do
    sequence(:name) {|n| "Team Group #{n}"}
  end
end
