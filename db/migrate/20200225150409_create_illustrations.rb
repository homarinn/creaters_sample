class CreateIllustrations < ActiveRecord::Migration[6.0]
  def change
    create_table :illustrations do |t|
      t.string :title, null: false
      t.text :author_comment
      t.references :user, foreign_key: true
      t.integer :illustration_series_id

      t.index :title
      t.timestamps
    end
  end
end
