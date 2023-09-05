class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.date :date_of_birth
      t.string :address
      t.integer :gender, default: 0, null: false
      t.integer :role, default: 0, null: false
      t.timestamps
    end
  end
end
