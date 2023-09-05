class CreateBooksAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :books_authors do |t|
      t.references :book, foreign_key: true, null: false
      t.references :author, foreign_key: true, null: false
      t.timestamps
    end
    add_index :books_authors, [:book_id, :author_id], unique: true
  end
end
