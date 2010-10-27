class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :code
      t.string :instructor
      t.string :title
      t.string :time
      t.text :time_parsed
      t.string :subject
      t.text :description
      t.integer :credits
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
