class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :book, null: false, foreign_key: true, index: true
      t.integer :rating
      t.text :comment
      t.timestamps
    end
  end
end
