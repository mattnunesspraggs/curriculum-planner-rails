class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.references :user
      t.string :slug
      t.text :content
      t.string :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
