class ApplicationController < ActionController::Base
  before_action :catch_criminals
  include Pundit::Authorization
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
      sanitized_locale = sanitize_param_value(params[:locale],allowed_punctuation)
      properly_cased_sanitized_locale = sanitized_locale.gsub(/-.*/, &:upcase).strip
      valid_locale = AvailableLocale.pluck(:key).include? properly_cased_sanitized_locale
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

  def sanitize_param_value(unsanitized_param_value, allowed_punctuation=[])
    # strip non printable characters and unallowed punctuation characters from unsanitized_param_value
    sanitized_item = unsanitized_param_value.to_s.gsub(/[^[:print:]]/, '').gsub(/[[:punct:]]/) { |item| (allowed_punctuation.include? item) ? item : "" } if unsanitized_param_value.present?
    sanitized_item
  end

  def catch_criminals
    # 2022-08 Getting lots of geniuses trying to POST JSON. Let's just give them an error without much info:
    # This globally blocks POSTing JSON. Bypass this filter in your controller if POSTing JSON is required.
    handle_posting_json

    # handle_posting_empty_bodyS

    handle_posting_empty_content_type

    post_param_not_allowed_value = SiteSetting.value("post_param_not_allowed")
    handle_bad_posts(post_param_not_allowed_value)

    path_not_allowed_value = SiteSetting.value("path_not_allowed")
    handle_bad_path(path_not_allowed_value)

    # Alright, we're just going to look at all params for SQLi. This is probably going
    # to slow us down a bit. Thanks a lot hacker fools.
    if params.present?
      handle_sql_injection_requests
    end

  end  #  def catch_criminals

  def handle_posting_json
    if request.content_type.to_s.match?(/json/i) && request.post?
      BadActorLog.create(ip_address: request.remote_ip, reason: "POSTing JSON", details: "#{request.inspect}\n\n#{request.env["RAW_POST_DATA"]}")
      log_bad_actors(request.remote_ip, "POSTing JSON")
      raise ActionController::UnpermittedParameters.new ["not allowed"]
    end
  end
  def handle_posting_empty_body
    if request.post? && request.raw_post.present?
      if request.raw_post.gsub("-","").empty?
        BadActorLog.create(ip_address: request.remote_ip, reason: "Empty POST", details: "#{request.inspect}\n\n#{request.raw_post}")
        log_bad_actors(request.remote_ip, "Empty POST")
        head :not_acceptable
      end
    end
  end
  def handle_posting_empty_content_type
    content_type = request.content_type.nil? ? "" : request.content_type.gsub("-","")
    if request.post? && content_type.empty?
      raw_post_data = request.raw_post.truncate(1250)
      BadActorLog.create(ip_address: request.remote_ip, reason: "Empty Content Type", details: "#{request.inspect}\n\n#{raw_post_data}")
      log_bad_actors(request.remote_ip, "Empty Content Type")
      head :not_acceptable
    end
  end
  def handle_bad_posts(post_param_not_allowed_value)
    if post_param_not_allowed_value.present? && request.post? && request.raw_post.present?
      bad_post_word_array = post_param_not_allowed_value.downcase.gsub(/\s/,"").split(",")
      bad_post_param_pattern = /\b(?:#{bad_post_word_array.join('|')})\b/i
      bad_post_found = request.raw_post.match?(bad_post_param_pattern)
      if bad_post_found
        raw_post_data = request.raw_post.truncate(1250)
        BadActorLog.create(ip_address: request.remote_ip, reason: "Bad Post", details: "#{request.inspect}\n\n#{raw_post_data}")
        log_bad_actors(request.remote_ip, "Bad Post")
        head :not_acceptable
      end
    end
  end
  def handle_bad_path(path_not_allowed_value)
    if path_not_allowed_value.present?
      bad_path_word_array = path_not_allowed_value.downcase.gsub(/\s/,"").split(",")
      bad_path_pattern = /(?:#{bad_path_word_array.map { |word| Regexp.escape(word) }.join('|')})/i
      bad_path_found = request.fullpath.match?(bad_path_pattern)
      if bad_path_found
        raw_post_data = request.raw_post.truncate(1250)
        BadActorLog.create(ip_address: request.remote_ip, reason: "Bad Path", details: "#{request.inspect}\n\n#{raw_post_data}")
        log_bad_actors(request.remote_ip, "Bad Path")
        head :not_acceptable
      end
    end
  end
  def handle_sql_injection_requests
      # checking all params as a string to avoid extra looping
      if has_sqli?(params.to_unsafe_h.flatten.to_s)
        BadActorLog.create(ip_address: request.remote_ip, reason: "SQLi attempt", details: "#{request.inspect}\n\n#{params.inspect}")
        log_bad_actors(request.remote_ip, "SQLi attempt")
        raise ActionController::UnpermittedParameters.new(["pESop jup"])
      end
  end

  def authorize_query!(query)
    if query.to_s.match(/union\s{1,}select/i) ||
       query.to_s.match(/(and|\&*)\s{1,}sleep/i) ||
       query.to_s.match(/order\s{1,}by/i) ||
       query.to_s.match(/query-1|1\=1/)
      raise ActionController::UnpermittedParameters.new ["query not allowed"]
    end
  end

  def log_bad_actors(ip_address, reason)
    logger = ActiveSupport::Logger.new("log/hpro_bad_actor.log")
    time = Time.now
    formatted_datetime = time.strftime('%Y-%m-%d %I:%M:%S %p')
    logger.error "#{ ip_address } - - [#{formatted_datetime}] \"#{ reason }\" ~~ #{request.inspect}"
  end

  def has_sqli?(input)
    sqli_pattern = /\b(?:SELECT|INSERT INTO|UPDATE|DELETE FROM|UNION)\b(?:\W+\w+\W+){0,10}?\b(?:CONCAT|FROM|INTO|SELECT|SLEEP|WHERE|VALUES)\b/i

    if input.respond_to?(:any?)
      input.any?(sqli_pattern)
    else
      input.to_s.match?(sqli_pattern)
    end
  end

  def us_states
    states = {
    "AL": "Alabama",
    "AK": "Alaska",
    # "AS": "American Samoa",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District Of Columbia",
    # "FM": "Federated States Of Micronesia",
    "FL": "Florida",
    "GA": "Georgia",
    # "GU": "Guam",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    # "MH": "Marshall Islands",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "NV": "Nevada",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    # "MP": "Northern Mariana Islands",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    # "PW": "Palau",
    "PA": "Pennsylvania",
    # "PR": "Puerto Rico",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VT": "Vermont",
    # "VI": "Virgin Islands",
    "VA": "Virginia",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming"
    }  #  states = {
    states
  end  #  us_states
  helper_method :us_states

  rescue_from ActionController::UnpermittedParameters do |error|
    render plain: error, status: 401
  end

end  #  class ApplicationController < ActionController::Base
