module ApplicationHelper

  def max_items_in_top_nav_columns
    6
  end

  def parent_verticals
    @parent_verticals ||= VerticalMarket.parent_verticals
  end

  def top_vertical_market_navigation(options)
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
    if c.length > 0
      content_tag(:ul, c.join.html_safe, class: options[:dropdowns] == true ? "dropdown" : "")
    end
  end

  def dropdown_class_for(vm, options={})
    css_class = "#{options[:class].to_s} "
    if options[:dropdowns]
      css_class += vm.children_or_reference_systems.length > 0 ? "has-dropdown" : ""
    end
    css_class
  end

  def top_menu_width_for(vm)
    # We only list 6 dependencies in a column, so divide by 6:
    # Then multiply by 3 since the columns are too narrow
    (vm.children_or_reference_systems.count.to_f / max_items_in_top_nav_columns.to_f).ceil * 3
  end

  def footer_menu_width_for(vm)
    vm.children_or_reference_systems.count > 10 ? 3 : 2
  end

  def format_headline(content)
    content.to_s.gsub(/\r\n|\r|\n/, "<br/>")
  end

  def current_locale
    @current_locale ||= AvailableLocale.where(key: I18n.locale).first_or_initialize
  end

  def active_locales
    @active_locales ||= AvailableLocale.where(live: true).order("name")
  end

end
