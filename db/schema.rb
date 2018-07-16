# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180716204152) do

  create_table "active_admin_comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "artists", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.text "overview"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.string "photo_content_type"
    t.datetime "photo_updated_at"
    t.integer "locale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["locale_id"], name: "index_artists_on_locale_id"
    t.index ["slug"], name: "index_artists_on_slug", unique: true
  end

  create_table "available_locales", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "live"
    t.boolean "show_hef", default: true
    t.index ["key"], name: "index_available_locales_on_key"
    t.index ["slug"], name: "index_available_locales_on_slug"
  end

  create_table "brand_distributors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "distributor_id"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_distributors_on_brand_id"
    t.index ["distributor_id"], name: "index_brand_distributors_on_distributor_id"
  end

  create_table "brand_news_articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "brand_id"
    t.integer "news_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_news_articles_on_brand_id"
    t.index ["news_article_id"], name: "index_brand_news_articles_on_news_article_id"
  end

  create_table "brand_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "brand_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "contact_info_for_consultants"
    t.index ["brand_id"], name: "index_brand_translations_on_brand_id"
    t.index ["locale"], name: "index_brand_translations_on_locale"
  end

  create_table "brands", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "white_logo_file_name"
    t.integer "white_logo_file_size"
    t.string "white_logo_content_type"
    t.datetime "white_logo_updated_at"
    t.string "slug"
    t.string "downloads_page_url"
    t.string "support_url"
    t.string "training_url"
    t.string "tech_url"
    t.boolean "show_on_main_site", default: true
    t.boolean "show_on_services_site", default: true
    t.boolean "show_on_consultant_page"
    t.string "api_url"
    t.string "by_harman_logo_file_name"
    t.integer "by_harman_logo_file_size"
    t.datetime "by_harman_logo_updated_at"
    t.string "by_harman_logo_content_type"
    t.string "marketing_url"
    t.string "logo_collection_file_name"
    t.integer "logo_collection_file_size"
    t.string "logo_collection_content_type"
    t.datetime "logo_collection_updated_at"
    t.string "tech_support_email"
    t.string "repair_email"
    t.string "parts_email"
    t.boolean "show_on_training_page"
    t.index ["show_on_main_site"], name: "index_brands_on_show_on_main_site"
    t.index ["show_on_services_site"], name: "index_brands_on_show_on_services_site"
    t.index ["slug"], name: "index_brands_on_slug"
  end

  create_table "case_studies", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.string "pdf_file_name"
    t.string "pdf_content_type"
    t.integer "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string "pdf_external_url"
  end

  create_table "case_study_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "case_study_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "headline"
    t.text "description"
    t.text "content"
    t.string "slug"
    t.index ["case_study_id"], name: "index_case_study_translations_on_case_study_id"
    t.index ["locale"], name: "index_case_study_translations_on_locale"
  end

  create_table "case_study_vertical_markets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "case_study_id"
    t.integer "vertical_market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "show_on_vertical_market_page", default: true
  end

  create_table "channel_countries", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channel_country_managers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "channel_manager_id"
    t.integer "channel_country_id"
    t.integer "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_country_id"], name: "index_channel_country_managers_on_channel_country_id"
    t.index ["channel_id"], name: "index_channel_country_managers_on_channel_id"
    t.index ["channel_manager_id"], name: "index_channel_country_managers_on_channel_manager_id"
  end

  create_table "channel_managers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_messages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.string "product"
    t.string "operating_system"
    t.string "message_type"
    t.string "company"
    t.string "account_number"
    t.string "phone"
    t.string "fax"
    t.string "billing_address"
    t.string "billing_city"
    t.string "billing_state"
    t.string "billing_zip"
    t.string "shipping_address"
    t.string "shipping_city"
    t.string "shipping_state"
    t.string "shipping_zip"
    t.string "product_sku"
    t.string "product_serial_number"
    t.boolean "warranty"
    t.date "purchased_on"
    t.string "part_number"
    t.string "board_location"
    t.string "shipping_country"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["brand_id"], name: "index_contact_messages_on_brand_id"
  end

  create_table "delayed_jobs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "distributors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "country"
    t.string "channel_manager"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "time_zone"
    t.text "details_public"
    t.text "details_private"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website"
  end

  create_table "emea_employee_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "department"
    t.string "job_function"
    t.string "position"
    t.string "name"
    t.string "email"
    t.string "telephone"
    t.string "mobile"
    t.string "brands"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department"], name: "index_emea_employee_contacts_on_department"
    t.index ["job_function"], name: "index_emea_employee_contacts_on_job_function"
  end

  create_table "emea_page_resources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "attachment_file_name"
    t.integer "attachment_file_size"
    t.string "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.boolean "featured"
    t.integer "position"
    t.string "link"
    t.boolean "new_window"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "emea_page_id"
    t.index ["emea_page_id"], name: "index_emea_page_resources_on_emea_page_id"
  end

  create_table "emea_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "slug"
    t.string "highlight_color"
    t.date "publish_on"
    t.text "content"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pinch_content", default: true
    t.text "custom_header_code"
    t.boolean "employee_only", default: false
    t.index ["slug"], name: "index_emea_pages_on_slug"
  end

  create_table "event_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.text "page_content"
    t.string "slug"
    t.index ["event_id"], name: "index_event_translations_on_event_id"
    t.index ["locale"], name: "index_event_translations_on_locale"
  end

  create_table "events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "start_on"
    t.date "end_on"
    t.boolean "featured"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "more_info_link"
    t.boolean "new_window"
    t.integer "original_locale_id"
    t.boolean "hide_image"
    t.index ["original_locale_id"], name: "index_events_on_original_locale_id"
  end

  create_table "features", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "featurable_type"
    t.integer "featurable_id"
    t.integer "position"
    t.string "layout_style"
    t.string "content_position"
    t.text "pre_content"
    t.text "content"
    t.string "image_file_name"
    t.string "image_content_type"
    t.datetime "image_updated_at"
    t.integer "image_file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["featurable_type", "featurable_id"], name: "index_features_on_featurable_type_and_featurable_id"
  end

  create_table "friendly_id_slugs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.string "locale"
    t.datetime "created_at"
    t.index ["locale"], name: "index_friendly_id_slugs_on_locale"
    t.index ["slug", "sluggable_type", "locale"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_locale", length: { slug: 140, locale: 2 }
    t.index ["slug", "sluggable_type", "scope", "locale"], name: "index_friendly_id_slugs_uniqueness", unique: true, length: { slug: 70, scope: 70, locale: 2 }
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "landing_page_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "landing_page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "subtitle"
    t.string "description"
    t.text "main_content"
    t.text "left_content"
    t.text "right_content"
    t.text "sub_content"
    t.string "slug"
    t.index ["landing_page_id"], name: "index_landing_page_translations_on_landing_page_id"
    t.index ["locale"], name: "index_landing_page_translations_on_locale"
  end

  create_table "landing_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide_title"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.datetime "banner_updated_at"
    t.integer "banner_file_size"
    t.integer "original_locale_id"
    t.text "header_code"
    t.text "footer_code"
    t.string "custom_slug"
    t.index ["original_locale_id"], name: "index_landing_pages_on_original_locale_id"
  end

  create_table "leads", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "company"
    t.string "email"
    t.string "phone"
    t.text "project_description"
    t.string "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "location"
    t.integer "vertical_market_id"
  end

  create_table "locale_translators", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "available_locale_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_locale_id"], name: "index_locale_translators_on_available_locale_id"
    t.index ["user_id"], name: "index_locale_translators_on_user_id"
  end

  create_table "media_library_access_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "relationship"
    t.string "employee_csu"
    t.string "employee_office"
    t.string "job_title"
    t.string "region"
    t.string "other_relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "locale_id"
    t.string "title"
    t.string "link"
    t.boolean "new_tab"
    t.boolean "enabled"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale_id"], name: "index_menu_items_on_locale_id"
  end

  create_table "news_articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "locale_id"
    t.string "title"
    t.text "body"
    t.text "keywords"
    t.date "post_on"
    t.string "news_photo_file_name"
    t.string "news_photo_content_type"
    t.integer "news_photo_file_size"
    t.datetime "news_photo_updated_at"
    t.text "quote"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale_id"], name: "index_news_articles_on_locale_id"
  end

  create_table "online_retailers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "slug"
    t.string "url"
    t.string "logo_file_name"
    t.integer "logo_file_size"
    t.string "logo_content_type"
    t.datetime "logo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "locale_id"
    t.index ["locale_id"], name: "index_online_retailers_on_locale_id"
    t.index ["slug"], name: "index_online_retailers_on_slug"
  end

  create_table "product_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "product_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "slug"
    t.index ["locale"], name: "index_product_translations_on_locale"
    t.index ["product_id"], name: "index_product_translations_on_product_id"
  end

  create_table "product_type_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "product_type_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "slug"
    t.index ["locale"], name: "index_product_type_translations_on_locale"
    t.index ["product_type_id"], name: "index_product_type_translations_on_product_type_id"
  end

  create_table "product_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "url"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "brand_id"
    t.string "ecommerce_id"
  end

  create_table "reference_system_product_type_products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "reference_system_product_type_id"
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["reference_system_product_type_id"], name: "r_s_p_t_id"
  end

  create_table "reference_system_product_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "reference_system_id"
    t.integer "product_type_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "top"
    t.string "left"
    t.index ["reference_system_id"], name: "index_reference_system_product_types_on_reference_system_id"
  end

  create_table "reference_system_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "reference_system_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "headline"
    t.string "venue_size_descriptor"
    t.text "description"
    t.string "slug"
    t.index ["locale"], name: "index_reference_system_translations_on_locale"
    t.index ["reference_system_id"], name: "index_reference_system_translations_on_reference_system_id"
  end

  create_table "reference_systems", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "vertical_market_id"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.string "system_diagram_file_name"
    t.string "system_diagram_content_type"
    t.integer "system_diagram_file_size"
    t.datetime "system_diagram_updated_at"
    t.index ["vertical_market_id"], name: "index_reference_systems_on_vertical_market_id"
  end

  create_table "resources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.integer "attachment_file_size"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.datetime "image_updated_at"
    t.integer "image_file_size"
  end

  create_table "service_center_service_groups", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "service_center_id"
    t.integer "service_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_center_id"], name: "index_service_center_service_groups_on_service_center_id"
    t.index ["service_group_id"], name: "index_service_center_service_groups_on_service_group_id"
  end

  create_table "service_centers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "fax"
    t.string "email"
    t.string "website"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_name"
    t.boolean "active", default: true
    t.index ["active"], name: "index_service_centers_on_active"
  end

  create_table "service_groups", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_service_groups_on_brand_id"
  end

  create_table "shorturls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "shortcut"
    t.string "full_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_setting_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "site_setting_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["locale"], name: "index_site_setting_translations_on_locale"
    t.index ["site_setting_id"], name: "index_site_setting_translations_on_site_setting_id"
  end

  create_table "site_settings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_site_settings_on_name", unique: true
  end

  create_table "slides", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "locale_id"
    t.integer "position"
    t.string "background_file_name"
    t.integer "background_file_size"
    t.string "background_content_type"
    t.datetime "background_updated_at"
    t.string "bubble_file_name"
    t.integer "bubble_file_size"
    t.string "bubble_content_type"
    t.datetime "bubble_updated_at"
    t.string "headline"
    t.string "description"
    t.string "link_text"
    t.string "link_url"
    t.boolean "link_new_window", default: false
    t.datetime "start_on"
    t.datetime "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "training_content_page_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "training_content_page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "subtitle"
    t.string "description"
    t.text "main_content"
    t.text "right_content"
    t.text "sub_content"
    t.string "slug"
    t.index ["locale"], name: "index_training_content_page_translations_on_locale"
    t.index ["training_content_page_id"], name: "index_d73f0ce584cd69245ae320eec6d9ea12689da0e6"
  end

  create_table "training_content_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide_title"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.datetime "banner_updated_at"
    t.integer "banner_file_size"
    t.integer "original_locale_id"
    t.text "header_code"
    t.text "footer_code"
    t.string "custom_slug"
    t.index ["original_locale_id"], name: "index_training_content_pages_on_original_locale_id"
  end

  create_table "tse_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.integer "position"
    t.index ["parent_id"], name: "index_tse_categories_on_parent_id"
  end

  create_table "tse_category_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tse_category_id"
    t.integer "tse_contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tse_category_id"], name: "index_tse_category_contacts_on_tse_category_id"
    t.index ["tse_contact_id"], name: "index_tse_category_contacts_on_tse_contact_id"
  end

  create_table "tse_contact_domains", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tse_contact_id"
    t.integer "tse_domain_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tse_contact_id"], name: "index_tse_contact_domains_on_tse_contact_id"
    t.index ["tse_domain_id"], name: "index_tse_contact_domains_on_tse_domain_id"
  end

  create_table "tse_contact_regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tse_contact_id"
    t.integer "tse_region_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tse_contact_id"], name: "index_tse_contact_regions_on_tse_contact_id"
    t.index ["tse_region_id"], name: "index_tse_contact_regions_on_tse_region_id"
  end

  create_table "tse_contact_technologies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tse_contact_id"
    t.integer "tse_technology_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tse_contact_id"], name: "index_tse_contact_technologies_on_tse_contact_id"
    t.index ["tse_technology_id"], name: "index_tse_contact_technologies_on_tse_technology_id"
  end

  create_table "tse_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "job_title"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "manager"
    t.string "company"
  end

  create_table "tse_domains", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tse_regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_tse_regions_on_parent_id"
  end

  create_table "tse_technologies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "service_department", default: false
    t.boolean "super_admin", default: false
    t.boolean "translator"
    t.boolean "admin", default: false
    t.boolean "emea_admin", default: false
    t.boolean "emea_distributor", default: false
    t.boolean "tse_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venue_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "venue_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "slug"
    t.index ["locale"], name: "index_venue_translations_on_locale"
    t.index ["venue_id"], name: "index_venue_translations_on_venue_id"
  end

  create_table "venues", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "left"
    t.string "top"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vertical_market_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vertical_market_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "headline"
    t.text "description"
    t.string "slug"
    t.text "lead_form_content"
    t.text "extra_content"
    t.index ["locale"], name: "index_vertical_market_translations_on_locale"
    t.index ["vertical_market_id"], name: "index_vertical_market_translations_on_vertical_market_id"
  end

  create_table "vertical_markets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.boolean "live", default: true
    t.string "background_file_name"
    t.string "background_content_type"
    t.integer "background_file_size"
    t.datetime "background_updated_at"
    t.boolean "retail", default: false
    t.boolean "hide_buy_section"
    t.boolean "show_hef"
    t.string "hef_banner_file_name"
    t.string "hef_banner_content_type"
    t.integer "hef_banner_file_size"
    t.datetime "hef_banner_updated_at"
    t.string "preview_code"
    t.string "icon_file_name"
    t.integer "icon_file_size"
    t.string "icon_content_type"
    t.datetime "icon_updated_at"
    t.index ["parent_id"], name: "index_vertical_markets_on_parent_id"
  end

end
