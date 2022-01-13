class Cms::AvailableLocalesController < CmsController
  before_action :load_available_locale
  before_action :set_locale_for_translator

  def show
  end

  def store_link
    @store_link = SiteSetting.find_by(name: "store_link")
    @store_link.content = params[:site_setting][:content]

    msg = (@store_link.save) ? {notice: "Success!"} : {alert: "Sorry, something went wrong. Try again."}
    @available_locale.touch
    redirect_to cms_available_locale_menu_items_path(@available_locale), msg
  end

  def blog_link
    @blog_link = SiteSetting.find_by(name: "blog_link")
    @blog_link_name = SiteSetting.find_by(name: "blog_link_name")

    @blog_link.content = params[:blog_link]
    @blog_link_name.content = params[:blog_link_name]

    @blog_link.save
    @blog_link_name.save

    @available_locale.touch
    redirect_to cms_available_locale_menu_items_path(@available_locale), notice: "Changes submitted."
  end

  def edit_consultants
    @intro = SiteSetting.find_by(name: "consultant-portal-welcome-paragraph")
    @contacts = SiteSetting.find_by(name: "consultant-portal-contacts")
    @contacts.content = RedCloth.new(@contacts.content).to_html
  end

  def update_consultants
    params[:site_setting].each do |sid,val|
      setting = SiteSetting.find(sid)
      setting.content = val["content"]
      setting.save
    end
    redirect_to [:cms, @available_locale], notice: "Consultant settings updated successfully."
  end

  private

  def load_available_locale
    @available_locale = AvailableLocale.find(params[:id])
  end

  def set_locale_for_translator
    if @available_locale
      I18n.locale = @available_locale.key.to_sym
    end
  end

end
