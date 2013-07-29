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

ActiveRecord::Schema.define(:version => 20130728222738) do

  create_table "fitbit_accounts", :force => true do |t|
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "fitbit_accounts", ["user_id"], :name => "index_fitbit_accounts_on_user_id"

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "recorded_at"
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "measurements", :force => true do |t|
    t.float    "value"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.datetime "recorded_at"
  end

  add_index "measurements", ["user_id"], :name => "index_measurements_on_user_id"

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.float    "height"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "weights", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.float    "bmi"
    t.float    "value"
    t.float    "lean_mass_value"
    t.float    "fat_mass_value"
    t.float    "fat_percentage"
    t.datetime "recorded_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.hstore   "meta"
    t.string   "source"
  end

  add_index "weights", ["meta"], :name => "index_weights_on_meta"
  add_index "weights", ["user_id"], :name => "index_weights_on_user_id"

  create_table "withings_accounts", :force => true do |t|
    t.string   "userid"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "oauth_token"
    t.integer  "user_id"
    t.string   "oauth_token_secret"
    t.datetime "synced_at"
  end

  add_index "withings_accounts", ["user_id"], :name => "index_withings_accounts_on_user_id"

end
