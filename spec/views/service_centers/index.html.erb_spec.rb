 require "rails_helper"

 RSpec.describe "service_centers/index.html.erb", as: :view do

   before :all do
     @service_center = FactoryBot.create(:service_center)
     @service_group = FactoryBot.create(:service_group)
     @service_center.service_groups << @service_group
   end

   before :each do
     @search = ServiceCenter.ransack()
     assign(:search, @search)
   end

   it "has the search form" do
     assign(:service_centers, [])
     render

     expect(response).to have_css("form[@action='#{ service_centers_path }']")
     expect(response).to have_css("select#q_state_eq")
     expect(response).to have_css("select#q_service_groups_name_eq")
   end

   describe "before searching" do
     before do
       render
     end

     it "does not show the no results message" do
       expect(response).not_to have_content("No search results found")
     end

     it "does not show the result table" do
       expect(response).not_to have_css("table")
     end
   end

   describe "after searching" do
     describe "results found" do
       before do
         assign(:service_centers, [@service_center])
         render
       end

       it "shows the results table" do
         expect(response).to have_css("table")
         expect(response).to have_content(@service_center.name)
       end

       it "shows which brands are serviced" do
         expect(response).to have_content(@service_group.name)
       end
     end

     it "shows no results found" do
       assign(:service_centers, [])
       render

       expect(response).to have_content("No search results found")
     end
   end
 end
