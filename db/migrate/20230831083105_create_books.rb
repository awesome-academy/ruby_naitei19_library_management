class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :published_year
      t.integer :book_amount
      t.references :publisher, foreign_key: true, index: true, null: false
      t.float :average_rating
      t.timestamps
    end
  end
end
