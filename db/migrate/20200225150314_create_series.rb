class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series do |t|
      t.string :title, null: false
      t.text :outline
      t.references :user, null: false, foreign_key: true
      t.string :type

      t.index :title
      t.timestamps
    end
  end
end
