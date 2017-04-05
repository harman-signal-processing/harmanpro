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

ActiveRecord::Schema.define(version: 20170328191524) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "service_department",     default: false
    t.boolean  "super_admin",            default: true
    t.boolean  "translator"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "artists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "description",        limit: 65535
    t.text     "overview",           limit: 65535
    t.string   "photo_file_name"
    t.integer  "photo_file_size"
    t.string   "photo_content_type"
    t.datetime "photo_updated_at"
    t.integer  "locale_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "slug"
    t.index ["locale_id"], name: "index_artists_on_locale_id", using: :btree
    t.index ["slug"], name: "index_artists_on_slug", unique: true, using: :btree
  end

  create_table "available_locales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.boolean  "live"
    t.index ["key"], name: "index_available_locales_on_key", using: :btree
    t.index ["slug"], name: "index_available_locales_on_slug", using: :btree
  end

  create_table "brand_news_articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "brand_id"
    t.integer  "news_article_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["brand_id"], name: "index_brand_news_articles_on_brand_id", using: :btree
    t.index ["news_article_id"], name: "index_brand_news_articles_on_news_article_id", using: :btree
  end

  create_table "brand_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "brand_id",                                   null: false
    t.string   "locale",                                     null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "description",                  limit: 65535
    t.text     "contact_info_for_consultants", limit: 65535
    t.index ["brand_id"], name: "index_brand_translations_on_brand_id", using: :btree
    t.index ["locale"], name: "index_brand_translations_on_locale", using: :btree
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "white_logo_file_name"
    t.integer  "white_logo_file_size"
    t.string   "white_logo_content_type"
    t.datetime "white_logo_updated_at"
    t.string   "slug"
    t.string   "downloads_page_url"
    t.string   "support_url"
    t.string   "training_url"
    t.string   "tech_url"
    t.boolean  "show_on_main_site",            default: true
    t.boolean  "show_on_services_site",        default: true
    t.boolean  "show_on_consultant_page"
    t.string   "api_url"
    t.string   "by_harman_logo_file_name"
    t.integer  "by_harman_logo_file_size"
    t.datetime "by_harman_logo_updated_at"
    t.string   "by_harman_logo_content_type"
    t.string   "marketing_url"
    t.string   "logo_collection_file_name"
    t.integer  "logo_collection_file_size"
    t.string   "logo_collection_content_type"
    t.datetime "logo_collection_updated_at"
    t.index ["show_on_main_site"], name: "index_brands_on_show_on_main_site", using: :btree
    t.index ["show_on_services_site"], name: "index_brands_on_show_on_services_site", using: :btree
    t.index ["slug"], name: "index_brands_on_slug", using: :btree
  end

  create_table "case_studies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
  end

  create_table "case_study_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "case_study_id",               null: false
    t.string   "locale",                      null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "headline"
    t.text     "description",   limit: 65535
    t.text     "content",       limit: 65535
    t.string   "slug"
    t.index ["case_study_id"], name: "index_case_study_translations_on_case_study_id", using: :btree
    t.index ["locale"], name: "index_case_study_translations_on_locale", using: :btree
  end

  create_table "case_study_vertical_markets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "case_study_id"
    t.integer  "vertical_market_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "event_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "event_id",                   null: false
    t.string   "locale",                     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name"
    t.text     "description",  limit: 65535
    t.text     "page_content", limit: 65535
    t.string   "slug"
    t.index ["event_id"], name: "index_event_translations_on_event_id", using: :btree
    t.index ["locale"], name: "index_event_translations_on_locale", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.date     "start_on"
    t.date     "end_on"
    t.boolean  "featured"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "more_info_link"
    t.boolean  "new_window"
    t.integer  "original_locale_id"
    t.boolean  "hide_image"
    t.index ["original_locale_id"], name: "index_events_on_original_locale_id", using: :btree
  end

  create_table "features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "featurable_type"
    t.integer  "featurable_id"
    t.integer  "position"
    t.string   "layout_style"
    t.string   "content_position"
    t.text     "pre_content",        limit: 65535
    t.text     "content",            limit: 65535
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["featurable_type", "featurable_id"], name: "index_features_on_featurable_type_and_featurable_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "landing_page_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "landing_page_id",               null: false
    t.string   "locale",                        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.text     "main_content",    limit: 65535
    t.text     "left_content",    limit: 65535
    t.text     "right_content",   limit: 65535
    t.text     "sub_content",     limit: 65535
    t.string   "slug"
    t.index ["landing_page_id"], name: "index_landing_page_translations_on_landing_page_id", using: :btree
    t.index ["locale"], name: "index_landing_page_translations_on_locale", using: :btree
  end

  create_table "landing_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "hide_title"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.datetime "banner_updated_at"
    t.integer  "banner_file_size"
    t.integer  "original_locale_id"
    t.text     "header_code",         limit: 65535
    t.text     "footer_code",         limit: 65535
    t.string   "custom_slug"
    t.index ["original_locale_id"], name: "index_landing_pages_on_original_locale_id", using: :btree
  end

  create_table "leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.string   "phone"
    t.text     "project_description", limit: 65535
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.integer  "vertical_market_id"
  end

  create_table "locale_translators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "available_locale_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["admin_user_id"], name: "index_locale_translators_on_admin_user_id", using: :btree
    t.index ["available_locale_id"], name: "index_locale_translators_on_available_locale_id", using: :btree
  end

  create_table "media_library_access_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "relationship"
    t.string   "employee_csu"
    t.string   "employee_office"
    t.string   "job_title"
    t.string   "region"
    t.string   "other_relationship"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "menu_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "locale_id"
    t.string   "title"
    t.string   "link"
    t.boolean  "new_tab"
    t.boolean  "enabled"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale_id"], name: "index_menu_items_on_locale_id", using: :btree
  end

  create_table "news_articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "locale_id"
    t.string   "title"
    t.text     "body",                    limit: 65535
    t.text     "keywords",                limit: 65535
    t.date     "post_on"
    t.string   "news_photo_file_name"
    t.string   "news_photo_content_type"
    t.integer  "news_photo_file_size"
    t.datetime "news_photo_updated_at"
    t.text     "quote",                   limit: 65535
    t.string   "slug"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["locale_id"], name: "index_news_articles_on_locale_id", using: :btree
  end

  create_table "online_retailers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "url"
    t.string   "logo_file_name"
    t.integer  "logo_file_size"
    t.string   "logo_content_type"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "locale_id"
    t.index ["locale_id"], name: "index_online_retailers_on_locale_id", using: :btree
    t.index ["slug"], name: "index_online_retailers_on_slug", using: :btree
  end

  create_table "product_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "product_id",                null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_product_translations_on_locale", using: :btree
    t.index ["product_id"], name: "index_product_translations_on_product_id", using: :btree
  end

  create_table "product_type_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "product_type_id",               null: false
    t.string   "locale",                        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name"
    t.text     "description",     limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_product_type_translations_on_locale", using: :btree
    t.index ["product_type_id"], name: "index_product_type_translations_on_product_type_id", using: :btree
  end

  create_table "product_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "url"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
    t.string   "ecommerce_id"
  end

  create_table "reference_system_product_type_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "reference_system_product_type_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["reference_system_product_type_id"], name: "r_s_p_t_id", using: :btree
  end

  create_table "reference_system_product_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "reference_system_id"
    t.integer  "product_type_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top"
    t.string   "left"
    t.index ["reference_system_id"], name: "index_reference_system_product_types_on_reference_system_id", using: :btree
  end

  create_table "reference_system_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "reference_system_id",                 null: false
    t.string   "locale",                              null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "headline"
    t.string   "venue_size_descriptor"
    t.text     "description",           limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_reference_system_translations_on_locale", using: :btree
    t.index ["reference_system_id"], name: "index_reference_system_translations_on_reference_system_id", using: :btree
  end

  create_table "reference_systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "vertical_market_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "system_diagram_file_name"
    t.string   "system_diagram_content_type"
    t.integer  "system_diagram_file_size"
    t.datetime "system_diagram_updated_at"
    t.index ["vertical_market_id"], name: "index_reference_systems_on_vertical_market_id", using: :btree
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.datetime "attachment_updated_at"
    t.integer  "attachment_file_size"
    t.string   "resource_type"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "description",             limit: 65535
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
  end

  create_table "service_center_service_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "service_center_id"
    t.integer  "service_group_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["service_center_id"], name: "index_service_center_service_groups_on_service_center_id", using: :btree
    t.index ["service_group_id"], name: "index_service_center_service_groups_on_service_group_id", using: :btree
  end

  create_table "service_centers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.string   "account_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "contact_name"
    t.boolean  "active",         default: true
    t.index ["active"], name: "index_service_centers_on_active", using: :btree
  end

  create_table "service_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_service_groups_on_brand_id", using: :btree
  end

  create_table "site_setting_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "site_setting_id",               null: false
    t.string   "locale",                        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "content",         limit: 65535
    t.index ["locale"], name: "index_site_setting_translations_on_locale", using: :btree
    t.index ["site_setting_id"], name: "index_site_setting_translations_on_site_setting_id", using: :btree
  end

  create_table "site_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_site_settings_on_name", unique: true, using: :btree
  end

  create_table "slides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.integer  "locale_id"
    t.integer  "position"
    t.string   "background_file_name"
    t.integer  "background_file_size"
    t.string   "background_content_type"
    t.datetime "background_updated_at"
    t.string   "bubble_file_name"
    t.integer  "bubble_file_size"
    t.string   "bubble_content_type"
    t.datetime "bubble_updated_at"
    t.string   "headline"
    t.string   "description"
    t.string   "link_text"
    t.string   "link_url"
    t.boolean  "link_new_window",         default: false
    t.datetime "start_on"
    t.datetime "end_on"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "training_content_page_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "training_content_page_id",               null: false
    t.string   "locale",                                 null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.text     "main_content",             limit: 65535
    t.text     "right_content",            limit: 65535
    t.text     "sub_content",              limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_training_content_page_translations_on_locale", using: :btree
    t.index ["training_content_page_id"], name: "index_d73f0ce584cd69245ae320eec6d9ea12689da0e6", using: :btree
  end

  create_table "training_content_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "hide_title"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.datetime "banner_updated_at"
    t.integer  "banner_file_size"
    t.integer  "original_locale_id"
    t.text     "header_code",         limit: 65535
    t.text     "footer_code",         limit: 65535
    t.string   "custom_slug"
    t.index ["original_locale_id"], name: "index_training_content_pages_on_original_locale_id", using: :btree
  end

  create_table "venue_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "venue_id",                  null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_venue_translations_on_locale", using: :btree
    t.index ["venue_id"], name: "index_venue_translations_on_venue_id", using: :btree
  end

  create_table "venues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "left"
    t.string   "top"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vertical_market_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "vertical_market_id",               null: false
    t.string   "locale",                           null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name"
    t.string   "headline"
    t.text     "description",        limit: 65535
    t.string   "slug"
    t.text     "lead_form_content",  limit: 65535
    t.text     "extra_content",      limit: 65535
    t.index ["locale"], name: "index_vertical_market_translations_on_locale", using: :btree
    t.index ["vertical_market_id"], name: "index_vertical_market_translations_on_vertical_market_id", using: :btree
  end

  create_table "vertical_markets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.boolean  "live",                    default: true
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "retail",                  default: false
    t.boolean  "hide_buy_section"
    t.boolean  "show_hef"
    t.index ["parent_id"], name: "index_vertical_markets_on_parent_id", using: :btree
  end

end
