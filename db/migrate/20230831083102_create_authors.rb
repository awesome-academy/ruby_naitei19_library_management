class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :country
      t.date :date_of_birth
      t.string :avatar
      t.timestamps
    end
  end
end
