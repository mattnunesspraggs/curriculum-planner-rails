class CreateTimePeriods < ActiveRecord::Migration
  def self.up
    create_table :time_periods do |t|
      t.string :time
      t.string :days
      t.integer :t_start_h
      t.integer :t_start_m
      t.integer :t_end_h
      t.integer :t_end_m

      t.timestamps
    end
    
    add_index :time_periods, :time, :unique => true
    
    create_table :courses_time_periods, :id => false do |t|
      t.references :course
      t.references :time_period
    end
  end

  def self.down
    drop_table :time_periods
    drop_table :courses_time_periods
  end
end
