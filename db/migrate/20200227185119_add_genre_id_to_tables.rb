class AddGenreIdToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :genre_id, :integer
    add_column :novels, :genre_id, :integer
    add_column :comics, :genre_id, :integer
  end
end
