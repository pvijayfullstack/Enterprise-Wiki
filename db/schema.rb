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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110821053558) do

  create_table "markups", :force => true do |t|
    t.string   "title",      :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "markups", ["title"], :name => "index_markups_on_title", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "path",           :limit => 100,                   :null => false
    t.string   "title",          :limit => 100,                   :null => false
    t.text     "body",                                            :null => false
    t.integer  "editor_id",                                       :null => false
    t.integer  "revision",                                        :null => false
    t.boolean  "is_private",                    :default => true, :null => false
    t.boolean  "is_protected",                  :default => true, :null => false
    t.integer  "markup_id",                                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commit_message"
  end

  add_index "pages", ["path", "revision"], :name => "index_pages_on_path_and_revision", :unique => true

  create_table "prefix_rules", :force => true do |t|
    t.integer  "role_id",                       :null => false
    t.integer  "rule_action_id",                :null => false
    t.string   "prefix",         :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prefix_rules", ["role_id", "rule_action_id", "prefix"], :name => "index_prefix_rules_on_role_id_and_rule_action_id_and_prefix", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "title",      :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["title"], :name => "index_roles_on_title", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id", :unique => true

  create_table "rule_actions", :force => true do |t|
    t.string   "title",      :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rule_actions", ["title"], :name => "index_rule_actions_on_title", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",             :limit => 40,                     :null => false
    t.boolean  "admin",                               :default => false, :null => false
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "authentication_token"
    t.integer  "failed_attempts",                     :default => 0
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
