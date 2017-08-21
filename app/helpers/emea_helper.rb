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
      content_tag :li, link_to_emea_page(page), class: page.slug
    end
  end

  def emea_nav_with_dropdowns(page)
    content_tag :li, class: "has-dropdown #{page.slug}" do
      link_to_emea_page(page) + emea_dropdown_for(page)
    end
  end

  def emea_dropdown_for(page)
    page.linked_anchors = []
    content_tag :ul, class: "dropdown" do
      page.anchors.map do |anchor|
        link_to_emea_anchor(page, anchor)
      end.join.html_safe
    end
  end

  def link_to_emea_anchor(page, anchor)
    begin
      a = nil
      if anchor.attributes["id"]
        a = anchor.attributes["id"].value
      elsif anchor.attributes["name"]
        a = anchor.attributes["name"].value
      end
      unless a.blank? || a.match(/top/i) || page.linked_anchors.include?(a)
        page.linked_anchors << a
        content_tag :li, link_to(titleize_anchor(a), emea_page_path(page, anchor: a))
      end
    rescue
    end
  end

  def link_to_emea_page(page)
    link_to page.title, page.is_home? ? emea_root_path : page
  end

  def titleize_anchor(a)
    a.titleize.gsub(/Av And/, "AV &")
  end
end
