class AddUniqueIndexToEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :publishers, :email, unique: true
  end
end
