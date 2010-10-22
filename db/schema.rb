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

ActiveRecord::Schema.define(:version => 20101012223753) do

  create_table "courses", :force => true do |t|
    t.string   "course_code", :null => false
    t.string   "instructor"
    t.string   "title"
    t.string   "time"
    t.text     "time_parsed"
    t.string   "subject"
    t.text     "description"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["course_code"], :name => "index_courses_on_course_code", :unique => true

  create_table "courses_schedules", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "schedule_id"
  end

  create_table "envelopes", :force => true do |t|
    t.integer  "recipient_id",                    :null => false
    t.integer  "message_id",                      :null => false
    t.boolean  "opened",       :default => false
    t.boolean  "deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "message_id"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "first_name",                :limit => 100, :default => ""
    t.string   "last_name",                 :limit => 100, :default => ""
    t.string   "preferred_name",            :limit => 100
    t.string   "class_year"
    t.string   "permissions",                              :default => "user"
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
