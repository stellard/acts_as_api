class CreateUsers < ActiveRecord::Migration
  def self.up
    
    create_table :users, :force => true do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.integer  "age"
      t.boolean  "active"
      t.timestamps
    end
    
  end

  def self.down
    drop_table :users
  end
end
