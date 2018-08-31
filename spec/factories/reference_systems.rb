FactoryBot.define do
  factory :reference_system do
    sequence(:name) {|n| "RefSystem#{n}"}
    vertical_market
    venue_size_descriptor { "RS Size" }
    headline { "RefSysHeadline" }
    description { "RefSysDescription" }
  end

end
