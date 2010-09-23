class CreateAllTables < ActiveRecord::Migration
  def self.up
     create_table :users do |t|
        t.column :login,                     :string, :limit => 40
        t.column :first_name,                      :string, :limit => 100, :default => '', :null => true
        t.column :last_name,                      :string, :limit => 100, :default => '', :null => true
        t.string :preferred_name, :limit => 100, :default => '', :null => true
        t.string :class_year
        t.string :permissions, :default => 'user'
        t.column :email,                     :string, :limit => 100
        t.column :crypted_password,          :string, :limit => 40
        t.column :salt,                      :string, :limit => 40
        t.column :created_at,                :datetime
        t.column :updated_at,                :datetime
        t.column :remember_token,            :string, :limit => 40
        t.column :remember_token_expires_at, :datetime
        t.column :activation_code,           :string, :limit => 40
        t.column :activated_at,              :datetime
      end
      add_index :users, :login, :unique => true
      
      create_table :courses do |t|
        t.string :course_code, :null => false
        t.string :instructor
        t.string :title
        t.string :time
        t.text :time_parsed
        t.string :subject
        t.string :id
        t.text :description
        t.integer :credits

        t.timestamps
      end
      add_index :courses, :course_code, :unique => true
      
      create_table :schedules do |t|
        t.references :user
        t.text :courses

        t.timestamps
      end
  end

  def self.down
     drop_table :users
     drop_table :schedules
     drop_table :courses
  end
end
