class CreateBooksCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :books_categories do |t|
      t.references :book, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
    end
    add_index :books_categories, [:book_id, :category_id], unique: true
  end
end
