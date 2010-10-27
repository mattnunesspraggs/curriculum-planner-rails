class AddMoreNamesToUsers < ActiveRecord::Migration
  def self.up
    #remove_column :users, :name
    add_column :users, :first_name, :string, :null => true
    add_column :users, :last_name, :string, :null => true
    add_column :users, :preferred_name, :string, :null => true
  end

  def self.down
    add_column :users, :name, :null => true
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :preferred_name
  end
end
