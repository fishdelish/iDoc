class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body, :null => false
      t.references :user
      t.references :documentation_page, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
