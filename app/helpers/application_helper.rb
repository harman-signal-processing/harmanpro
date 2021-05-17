module ApplicationHelper

  def parent_verticals
    @parent_verticals ||= VerticalMarket.parent_verticals
  end

  def active_child_verticals
    @active_child_verticals ||= VerticalMarket.active_child_verticals
  end

  def top_vertical_market_navigation(options)
    active_child_verticals.map do |vm|
      menu_link_for(vm, options)
    end.join.html_safe
  end

  # This one isn't used anymore after combining Enterprise/Entertainment
  def parent_vertical_market_navigation(options)
    parent_verticals.map do |vm|
      menu_link_for(vm, options)
    end.join.html_safe
  end

  def menu_link_for(item, options={})
    if item.is_a?(ReferenceSystem)
      content_tag(:li, class: dropdown_class_for(item, options)) do
        link_to(item.name, [item.vertical_market, item])
      end
    else
      tree_links = (options[:dropdowns] == true) ? tree_links_for(item, options) : ''
      content_tag(:li, class: dropdown_class_for(item, options)) do
        link_to(item.name, item) + tree_links
      end
    end
  end

  def tree_links_for(vm, options={})
    c = []
    c = vm.children_or_reference_systems.map do |cvm|
      menu_link_for(cvm, options)
    end
    if c.size > 0
      content_tag(:ul, c.join.html_safe, class: options[:dropdowns] == true ? "dropdown" : "")
    end
  end

  def dropdown_class_for(vm, options={})
    css_class = "#{options[:class].to_s} "
    if options[:dropdowns]
      css_class += vm.children_or_reference_systems.size > 0 ? "has-dropdown" : ""
    end
    css_class
  end

  def format_headline(content)
    content.to_s.gsub(/\r\n|\r|\n/, "<br/>")
  end

  def current_locale
    @current_locale ||= AvailableLocale.where(key: I18n.locale).first_or_initialize
  end

  def active_locales
    @active_locales ||= AvailableLocale.where(live: true).order(Arel.sql("name"))
  end

end
