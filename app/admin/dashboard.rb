ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
#    div class: "blank_slate_container", id: "dashboard_default_message" do
#      span class: "blank_slate" do
#        span I18n.t("active_admin.dashboard_welcome.welcome")
#        small I18n.t("active_admin.dashboard_welcome.call_to_action")
#      end
#    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    # :nocov:
    columns do
      column do
        panel "Top-level Verticals" do
          ul do
            VerticalMarket.parent_verticals.map do |vm|
              li link_to(vm.name, admin_vertical_market_path(vm))
            end
          end
        end
      end
      column do
        panel "Some Instructions" do
          para "Here are some quick notes to help you get started."
          h3 "Vertical Markets"
          para "Choose any of the top-level vertical markets on this page. There you can click on any of the child verticals (if any) or work with Reference Systems."
          para "You should also edit the vertical market by clicking the 'Edit Vertical Market' link at the top of that page. Provide all of the necessary fields. Content limits are in place in the form itself."
          h3 "Reference Systems"
          para "If the selected vertical market is not a parent of any other verticals, then you can click on the link to create a new Reference System. Up to six will be visible on the vertical market page. Complete the subsequent form to create it. Limits are already in place for content length."
          h3 "Case Studies"
          para "Vertical markets also have Case Studies. Up to three of these may appear mid-way down on the vertical market page. Create/edit them the same way you do for Reference Systems."
          h3 "Top Nav"
          para "The 'Vertical Markets' link at the top of this page links to ALL of the verticals. If you land on this page, click on the 'edit' or 'view' links corresponding to the vertical market you wish to view."
          para "Just under the top navigation, look for breadcrumbs. These are pretty handy for quickly getting where you need."
        end
      end
    end
    # :nocov:

  end # content
end
