module EmeaHelper

  def emea_top_nav_items
    EmeaPage.for_top_nav.map do |page|
      emea_nav_for(page)
    end.join.html_safe
  end

  def emea_nav_for(page)
    if page.has_anchors?
      emea_nav_with_dropdowns(page)
    else
      content_tag :li, link_to_emea_page(page)
    end
  end

  def emea_nav_with_dropdowns(page)
    content_tag :li, class: "has-dropdown" do
      link_to_emea_page(page) + emea_dropdown_for(page)
    end
  end

  def emea_dropdown_for(page)
    content_tag :ul, class: "dropdown" do
      page.anchors.map do |anchor|
        link_to_emea_anchor(page, anchor)
      end.join.html_safe
    end
  end

  def link_to_emea_anchor(page, anchor)
    a = anchor.attributes["id"].value
    content_tag :li, link_to(a.titleize, emea_page_path(page, anchor: a))
  end

  def link_to_emea_page(page)
    link_to page.title, page.is_home? ? emea_root_path : page
  end
end
