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

ActiveRecord::Schema.define(:version => 20111024172655) do

  create_table "reports", :force => true do |t|
    t.string   "tag",                                                                                                   :null => false
    t.text     "description"
    t.string   "method"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.datetime "reported"
    t.datetime "found"
    t.decimal  "length",                                                                  :precision => 6, :scale => 2
    t.decimal  "weight",                                                                  :precision => 6, :scale => 2
    t.string   "fishtype"
    t.spatial  "location",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
  end

  add_index "reports", ["location"], :name => "index_reports_on_location", :spatial => true
  add_index "reports", ["tag"], :name => "index_reports_on_tag"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.boolean  "approved",                              :default => false, :null => false
    t.string   "name"
  end

  add_index "users", ["approved"], :name => "index_users_on_approved"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
