class AddOutlineToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :novels, :outline, :text
  end
end
