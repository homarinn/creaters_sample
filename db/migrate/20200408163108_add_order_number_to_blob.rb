class AddOrderNumberToBlob < ActiveRecord::Migration[6.0]
  def change
    add_column :active_storage_blobs, :order_number, :integer
  end
end
