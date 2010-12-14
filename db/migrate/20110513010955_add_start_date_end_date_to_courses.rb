class AddStartDateEndDateToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.date :start_date, :null => true
      t.date :end_date, :null => true
    end
    
    Course.update_all ["start_date = ?, end_date = ?", nil, nil]
  end

  def self.down
    remove_column :courses, :start_date
    remove_column :courses, :end_date
  end
end
