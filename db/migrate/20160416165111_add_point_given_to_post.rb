class AddPointGivenToPost < ActiveRecord::Migration
  def change
    add_column :posts, :point_given, :boolean
  end
end
