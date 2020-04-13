class AddContentToNovel < ActiveRecord::Migration[6.0]
  def change
    add_column :novels, :content, :text
  end
end
