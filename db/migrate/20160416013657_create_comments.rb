class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.integer :mood_at_time
      t.boolean :top_comment
      t.boolean :bad_comment

      t.timestamps null: false
    end
  end
end
