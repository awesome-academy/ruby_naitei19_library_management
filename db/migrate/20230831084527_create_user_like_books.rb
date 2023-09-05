class CreateUserLikeBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_like_books do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :book, foreign_key: true, index: true, null: false
      t.timestamps
    end
    add_index :user_like_books, [:user_id, :book_id], unique: true
  end
end
