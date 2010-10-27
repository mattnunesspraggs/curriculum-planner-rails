class AddCoursesUsersLinkTable < ActiveRecord::Migration
  def self.up
    create_table :courses_users, :id => false do |t|
      t.references :user
      t.references :course
    end
  end

  def self.down
    drop_table :courses_users
  end
end
