class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks, :force => true do |t|
      t.integer  "user_id"
      t.string   "heading"
      t.string   "description"
      t.integer  "time_spent"
      t.boolean  "done"
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
