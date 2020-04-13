class AddWorksCountToSeries < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_storage_blobs, :order_number, :integer
    add_column :series, :works_count, :integer, default: 0
  end
end
