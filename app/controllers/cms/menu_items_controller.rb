class Cms::MenuItemsController < CmsController
  before_action :set_locale_for_translator

  def index
    if @available_locale
      @store_link = SiteSetting.find_by(name: "store_link")
      @blog_link = SiteSetting.find_by(name: "blog_link")
      @blog_link_name = SiteSetting.find_by(name: "blog_link_name")
      render template: 'cms/available_locales/menu_items/index' and return false
    end
  end

  def new
    @menu_item = MenuItem.new
    if @available_locale
      render template: 'cms/available_locales/menu_items/new' and return false
    end
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @available_locale
      @menu_item.locale = @available_locale
      if @menu_item.save
        redirect_to cms_available_locale_menu_items_path(@available_locale), notice: "Success!"
      else
        render template: 'cms/available_locales/menu_items/new' and return false
      end
    end
  end

  def add_defaults
    if @available_locale
      I18n.locale = @available_locale.key
      last_item = MenuItem.where(locale: @available_locale).order(Arel.sql('position')).last
      MenuItem.where(locale_id: nil).each do |mi|
        new_mi = mi.dup
        new_mi.locale = @available_locale
        new_mi.title = I18n.t(mi.title)
        if last_item
          new_mi.position += last_item.position
        end
        new_mi.save
      end
      redirect_to cms_available_locale_menu_items_path(@available_locale), notice: "Default menu items were added to the #{@available_locale.name} site."
    end
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/menu_items/edit' and return false
    end
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    if @available_locale
      @menu_item.locale = @available_locale
      if @menu_item.update(menu_item_params)
        redirect_to [:cms, @available_locale, :menu_items], notice: "Success!"
      else
        render action: :edit
      end
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    redirect_to [:cms, @available_locale, :menu_items], notice: "'#{@menu_item.title}' was deleted."
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:title, :link, :position, :new_tab)
  end
end
