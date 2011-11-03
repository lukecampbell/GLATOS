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

ActiveRecord::Schema.define(:version => 20111103202042) do

  create_table "deployments", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "study_id"
    t.spatial  "location", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
  end

  add_index "deployments", ["location"], :name => "index_deployments_on_location", :spatial => true

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

  create_table "studies", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "start"
    t.datetime "end"
    t.string   "url"
    t.string   "species"
    t.integer  "user_id"
  end

  create_table "tag_deployments", :force => true do |t|
    t.integer  "tag_id"
    t.string   "tagger"
    t.string   "common_name"
    t.string   "scientific_name"
    t.string   "capture_location"
    t.spatial  "capture_geo",                               :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "capture_date"
    t.decimal  "capture_depth",                                                                                         :precision => 6, :scale => 2
    t.string   "wild_or_hatchery"
    t.string   "stock"
    t.decimal  "length",                                                                                                :precision => 6, :scale => 2
    t.decimal  "weight",                                                                                                :precision => 6, :scale => 2
    t.decimal  "age",                                                                                                   :precision => 5, :scale => 2
    t.string   "sex"
    t.boolean  "dna_sample_taken"
    t.string   "treatment_type"
    t.decimal  "temperature_change",                                                                                    :precision => 4, :scale => 2
    t.decimal  "holding_temperature",                                                                                   :precision => 4, :scale => 2
    t.string   "surgery_location"
    t.spatial  "surgery_geo",                               :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "surgery_date"
    t.string   "sedative"
    t.string   "sedative_concentration"
    t.string   "anaesthetic"
    t.string   "buffer"
    t.string   "anaesthetic_concentration"
    t.string   "buffer_concentration_in_anaesthetic"
    t.string   "anesthetic_concentration_in_recirculation"
    t.string   "buffer_concentration_in_recirculation"
    t.integer  "do"
    t.text     "description"
    t.string   "release_group"
    t.string   "release_location"
    t.spatial  "release_geo",                               :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "release_date"
  end

  add_index "tag_deployments", ["capture_geo"], :name => "index_tag_deployments_on_capture_geo", :spatial => true
  add_index "tag_deployments", ["release_geo"], :name => "index_tag_deployments_on_release_geo", :spatial => true
  add_index "tag_deployments", ["surgery_geo"], :name => "index_tag_deployments_on_surgery_geo", :spatial => true
  add_index "tag_deployments", ["tag_id"], :name => "index_tag_deployments_on_tag_id"

  create_table "tags", :force => true do |t|
    t.integer  "study_id"
    t.string   "serial"
    t.string   "code"
    t.string   "code_space"
    t.string   "lifespan"
    t.datetime "endoflife"
    t.string   "model"
    t.string   "manufacturer"
    t.string   "type"
    t.text     "description"
  end

  add_index "tags", ["model"], :name => "index_tags_on_model"
  add_index "tags", ["study_id"], :name => "index_tags_on_study_id"

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
    t.string   "organization"
    t.string   "requested_role"
  end

  add_index "users", ["approved"], :name => "index_users_on_approved"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
