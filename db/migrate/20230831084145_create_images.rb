class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :book, foreign_key: true, null: false
      t.string :image
      t.timestamps
    end
  end
end
