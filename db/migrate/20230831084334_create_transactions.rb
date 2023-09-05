class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false
      t.date :borrow_date
      t.date :expire_date
      t.integer :status, default: 0, null: false
      t.string :reason_failed, default: nil
      t.integer :amount
      t.timestamps
    end
  end
end
