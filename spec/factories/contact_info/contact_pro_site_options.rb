FactoryBot.define do
  factory :contact_info_contact_pro_site_option, class: 'ContactInfo::ContactProSiteOption' do
    showonweb { false }
    showforsolutions { false }
    showforchannels { false }
    association :contact, factory: :contact_info_contact
  end
end
