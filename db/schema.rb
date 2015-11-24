# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151124164825) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "service_department",                 default: false
    t.boolean  "super_admin",                        default: true
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "url",                          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name",               limit: 255
    t.string   "logo_content_type",            limit: 255
    t.integer  "logo_file_size",               limit: 4
    t.datetime "logo_updated_at"
    t.text     "description",                  limit: 65535
    t.string   "white_logo_file_name",         limit: 255
    t.integer  "white_logo_file_size",         limit: 4
    t.string   "white_logo_content_type",      limit: 255
    t.datetime "white_logo_updated_at"
    t.string   "slug",                         limit: 255
    t.string   "downloads_page_url",           limit: 255
    t.string   "support_url",                  limit: 255
    t.string   "training_url",                 limit: 255
    t.string   "tech_url",                     limit: 255
    t.boolean  "show_on_main_site",                          default: true
    t.boolean  "show_on_services_site",                      default: true
    t.boolean  "show_on_consultant_page"
    t.text     "contact_info_for_consultants", limit: 65535
    t.string   "api_url",                      limit: 255
    t.string   "by_harman_logo_file_name",     limit: 255
    t.integer  "by_harman_logo_file_size",     limit: 4
    t.datetime "by_harman_logo_updated_at"
    t.string   "by_harman_logo_content_type",  limit: 255
    t.string   "marketing_url",                limit: 255
    t.string   "logo_collection_file_name",    limit: 255
    t.integer  "logo_collection_file_size",    limit: 4
    t.string   "logo_collection_content_type", limit: 255
    t.datetime "logo_collection_updated_at"
  end

  add_index "brands", ["show_on_main_site"], name: "index_brands_on_show_on_main_site", using: :btree
  add_index "brands", ["show_on_services_site"], name: "index_brands_on_show_on_services_site", using: :btree
  add_index "brands", ["slug"], name: "index_brands_on_slug", using: :btree

  create_table "case_studies", force: :cascade do |t|
    t.string   "headline",            limit: 255
    t.text     "description",         limit: 65535
    t.integer  "vertical_market_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                limit: 255
    t.text     "content",             limit: 65535
    t.string   "banner_file_name",    limit: 255
    t.string   "banner_content_type", limit: 255
    t.integer  "banner_file_size",    limit: 4
    t.datetime "banner_updated_at"
  end

  add_index "case_studies", ["slug"], name: "index_case_studies_on_slug", unique: true, using: :btree
  add_index "case_studies", ["vertical_market_id"], name: "index_case_studies_on_vertical_market_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "landing_pages", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "subtitle",      limit: 255
    t.string   "slug",          limit: 255
    t.text     "main_content",  limit: 65535
    t.text     "left_content",  limit: 65535
    t.text     "right_content", limit: 65535
    t.text     "sub_content",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "description",   limit: 255
  end

  add_index "landing_pages", ["slug"], name: "index_landing_pages_on_slug", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "company",             limit: 255
    t.string   "email",               limit: 255
    t.string   "phone",               limit: 255
    t.text     "project_description", limit: 65535
    t.string   "source",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location",            limit: 255
  end

  create_table "online_retailers", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "slug",              limit: 255
    t.string   "url",               limit: 255
    t.string   "logo_file_name",    limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.string   "logo_content_type", limit: 255
    t.datetime "logo_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "online_retailers", ["slug"], name: "index_online_retailers_on_slug", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "slug",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_types", ["slug"], name: "index_product_types_on_slug", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.string   "slug",               limit: 255
    t.string   "url",                limit: 255
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id",           limit: 4
    t.string   "ecommerce_id",       limit: 255
  end

  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "reference_system_product_type_products", force: :cascade do |t|
    t.integer  "reference_system_product_type_id", limit: 4
    t.integer  "product_id",                       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reference_system_product_type_products", ["reference_system_product_type_id"], name: "r_s_p_t_id", using: :btree

  create_table "reference_system_product_types", force: :cascade do |t|
    t.integer  "reference_system_id", limit: 4
    t.integer  "product_type_id",     limit: 4
    t.integer  "quantity",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top",                 limit: 255
    t.string   "left",                limit: 255
  end

  add_index "reference_system_product_types", ["reference_system_id"], name: "index_reference_system_product_types_on_reference_system_id", using: :btree

  create_table "reference_systems", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.integer  "vertical_market_id",          limit: 4
    t.boolean  "retail",                                    default: false
    t.integer  "position",                    limit: 4
    t.string   "venue_size_descriptor",       limit: 255
    t.string   "headline",                    limit: 255
    t.text     "description",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name",            limit: 255
    t.string   "banner_content_type",         limit: 255
    t.integer  "banner_file_size",            limit: 4
    t.datetime "banner_updated_at"
    t.string   "slug",                        limit: 255
    t.string   "system_diagram_file_name",    limit: 255
    t.string   "system_diagram_content_type", limit: 255
    t.integer  "system_diagram_file_size",    limit: 4
    t.datetime "system_diagram_updated_at"
  end

  add_index "reference_systems", ["slug"], name: "index_reference_systems_on_slug", unique: true, using: :btree
  add_index "reference_systems", ["vertical_market_id"], name: "index_reference_systems_on_vertical_market_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.datetime "attachment_updated_at"
    t.integer  "attachment_file_size",    limit: 4
    t.string   "resource_type",           limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "description",             limit: 65535
  end

  create_table "service_center_service_groups", force: :cascade do |t|
    t.integer  "service_center_id", limit: 4
    t.integer  "service_group_id",  limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "service_center_service_groups", ["service_center_id"], name: "index_service_center_service_groups_on_service_center_id", using: :btree
  add_index "service_center_service_groups", ["service_group_id"], name: "index_service_center_service_groups_on_service_group_id", using: :btree

  create_table "service_centers", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "address",        limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.string   "zip",            limit: 255
    t.string   "phone",          limit: 255
    t.string   "fax",            limit: 255
    t.string   "email",          limit: 255
    t.string   "website",        limit: 255
    t.string   "account_number", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "contact_name",   limit: 255
    t.boolean  "active",                     default: true
  end

  add_index "service_centers", ["active"], name: "index_service_centers_on_active", using: :btree

  create_table "service_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "brand_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "service_groups", ["brand_id"], name: "index_service_groups_on_brand_id", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_settings", ["name"], name: "index_site_settings_on_name", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "left",        limit: 255
    t.string   "top",         limit: 255
    t.string   "slug",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "venues", ["slug"], name: "index_venues_on_slug", using: :btree

  create_table "vertical_markets", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "parent_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "headline",            limit: 255
    t.text     "description",         limit: 65535
    t.string   "slug",                limit: 255
    t.string   "banner_file_name",    limit: 255
    t.string   "banner_content_type", limit: 255
    t.integer  "banner_file_size",    limit: 4
    t.datetime "banner_updated_at"
  end

  add_index "vertical_markets", ["parent_id"], name: "index_vertical_markets_on_parent_id", using: :btree
  add_index "vertical_markets", ["slug"], name: "index_vertical_markets_on_slug", unique: true, using: :btree

end
