FactoryBot.define do
  factory :media_library_access_request do
    first_name { "FirstName" }
    last_name { "LastName" }
    email { "MyEmail" }
    company { "MyCompany" }
    relationship { "MyRelationship" }
    employee_office { "MyOffice" }
    job_title { "MyJobTitle" }
    region { "MyRegion" }
    other_relationship { "MyOtherRelationship" }
    reason_for_request { "MyReasoning" }
    what_assets { "MyAssetsNeeded" }
  end
end
