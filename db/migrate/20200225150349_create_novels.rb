class CreateNovels < ActiveRecord::Migration[6.0]
  def change
    create_table :novels do |t|
      t.string :title, null: false
      t.text :preface
      t.text :postscript
      t.references :user, null: false, foreign_key: true
      t.integer :novel_series_id

      t.index :title
      t.timestamps
    end
  end
end
