class AddPostedAtToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :posted_at, :datetime
    add_column :novels, :posted_at, :datetime
    add_column :illustrations, :posted_at, :datetime
    add_column :comics, :posted_at, :datetime
  end
end
