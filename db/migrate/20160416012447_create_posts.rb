class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :mood_at_time
      t.boolean :active

      t.timestamps null: false
    end
  end
end
