class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :set_locale, :save_passed_in_amx_trade_site_user_in_session_cookie
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  layout :select_layout

  def add_log(attributes)
    if attributes[:user]
      attributes[:user_id] = attributes[:user].id
      attributes.delete(:user)
    end
    begin
      AdminLog.create(attributes)
    rescue
      # don't worry if we can't log stuff
    end
  end

  private

  def select_layout
    "embedded" if params[:embed] == "true"
  end

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
    @landing_page.main_content = @landing_page.main_content.to_s.gsub(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.left_content = @landing_page.left_content.to_s.gsub(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.right_content = @landing_page.right_content.to_s.gsub(/\~+(\w*)\~+/) { eval($1) }
    @landing_page.sub_content = @landing_page.sub_content.to_s.gsub(/\~+(\w*)\~+/) { eval($1) }
    if @landing_page.live? || special_access_granted?(@landing_page)
      render "landing_pages/show"
    else
      redirect_to root_path and return false
    end
  end

  def get_training_content_page(slug)
    if TrainingContentPage.exists?(slug: slug)
      @training_content_page = TrainingContentPage.find(slug)
      if @training_content_page.custom_slug.present?
        redirect_to training_content_page_url(@training_content_page.custom_slug), status: 301 and return false
      end
    elsif TrainingContentPage.exists?(custom_slug: slug)
      @training_content_page = TrainingContentPage.find_by(custom_slug: slug)
    else
      @training_content_page = TrainingContentPage.new
    end
    @training_content_page.main_content.to_s
    @training_content_page.right_content.to_s
    @training_content_page.sub_content.to_s
  end  #  def render_training_content_page(slug)

  def set_locale
    if params[:locale].present?
      allowed_punctuation = ["-"]
      # strip non printable characters and unallowed punctuation characters from locale param
      sanitized_locale = params[:locale].gsub(/[^[:print:]]/, '').gsub(/[[:punct:]]/) { |item| (allowed_punctuation.include? item) ? item : "" }
      properly_cased_sanitized_locale = sanitized_locale.gsub(/-.*/, &:upcase).strip
      valid_locale = AvailableLocale.where("live=1").pluck(:key).include? properly_cased_sanitized_locale
      session[:locale] = properly_cased_sanitized_locale if valid_locale
    end
    if session[:locale].present?
      I18n.locale = session[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(AvailableLocale.live) ||
        I18n.default_locale
    end
    @current_locale = AvailableLocale.where(key: I18n.locale).first_or_initialize

    @geo_ip = GEOIP_DB.lookup(request.remote_ip)
  end

  def all_brands
    Brand.all_for_site
  end
  helper_method :all_brands

  def track_last_page
    session["last_page"] = request.path
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.admin_access?
  end

  def authenticate_cms_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.cms_user?
  end

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:invitation_code])
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

  # For dynamically inserting all the active vertical markets grid with:
  # ~solutions_grid~
  def solutions_grid
    render_to_string partial: "vertical_markets/grid"
  end

  def save_passed_in_amx_trade_site_user_in_session_cookie
    if params[:ud].present?
      encoded_hash = params[:ud] # This would be encoded user email and userid sent in from trade.amx.com
      #user = ActiveSupport::JSON.decode(Base64.decode64(encoded_hash)).symbolize_keys
      training_user = JSON.parse(Base64.decode64(encoded_hash), symbolize_names: true)
      session[:training_user] = training_user
      session[:training_user_encoded] = encoded_hash
    end
  end  #  def save_passed_in_amx_trade_site_user_in_session_cookie

  def special_access_granted?(item)
    preview_code_provided?(item) || admin_logged_in?
  end

  def admin_logged_in?
    user_signed_in? && (current_user.admin_access? || curent_user.cms_user?)
  end

  def preview_code_provided?(item)
    item.respond_to?(:preview_code) && item.preview_code.present? && params[:preview_code] == item.preview_code
  end

  # Utility function used to re-order an ActiveRecord list
  # Pass in a model name and a list of ordered objects
  def update_list_order(model, order)
    order.to_a.each_with_index do |item, pos|
      model.update(item, position:(pos + 1))
    end
  end

  def clean_country_code(country_code)
    country_code.gsub(/[^a-zA-Z]/, '').slice(0..1).downcase
  end
  helper_method :clean_country_code

end  #  class ApplicationController < ActionController::Base
