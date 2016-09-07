class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def render_landing_page(slug)
    if LandingPage.exists?(slug: slug)
      @landing_page = LandingPage.find(slug)
      if @landing_page.custom_slug.present?
        redirect_to landing_page_url(@landing_page.custom_slug), status: 301 and return false
      end
    elsif LandingPage.exists?(custom_slug: slug)
      @landing_page = LandingPage.find_by(custom_slug: slug)
    else
      @landing_page = LandingPage.new
    end
    @landing_page.main_content.to_s.gsub!(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.left_content.to_s.gsub!(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.right_content.to_s.gsub!(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.sub_content.to_s.gsub!(/\~+(\w*)\~+/) { eval($1) }
    render "landing_pages/show"
  end

  def set_locale
    if params[:locale].present?
      session[:locale] = params[:locale]
    end
    if session[:locale].present?
      I18n.locale = session[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(AvailableLocale.live) ||
        I18n.default_locale
    end
    @current_locale = AvailableLocale.where(key: I18n.locale).first_or_initialize
  end

  def all_brands
    Brand.all_for_site
  end
  helper_method :all_brands

  def track_last_page
    session["last_page"] = request.path
  end

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def pundit_user
    current_admin_user
  end

  # For dynamically inserting contact forms into landing pages with:
  #  ~contact_form~
  def contact_form
    @lead ||= Lead.new(project_description: '')
    render_to_string partial: "leads/form", locals: { body_label: I18n.t("message") }
  end

  # For dynamically inserting contact forms into landing pages with:
  #  ~lead_form~
  def lead_form
    @lead ||= Lead.new
    render_to_string partial: "leads/form"
  end

end
