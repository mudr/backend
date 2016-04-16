class AddPointTakenToPost < ActiveRecord::Migration
  def change
    add_column :posts, :point_taken, :boolean
  end
end
