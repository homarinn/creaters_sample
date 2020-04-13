class AddOutlineToComics < ActiveRecord::Migration[6.0]
  def change
    add_column :comics, :outline, :text
  end
end
