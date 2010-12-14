class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :key
      t.text :value
      t.boolean :serialized

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
