class AddStatusToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :novels, :status, :integer, default: 0
    add_column :illustrations, :status, :integer, default: 0
    add_column :comics, :status, :integer, default: 0
    add_column :series, :status, :integer, default: 0

    add_index :novels, :status
    add_index :illustrations, :status
    add_index :comics, :status
    add_index :series, :status
  end
end
