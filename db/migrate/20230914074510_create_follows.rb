class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :followable, polymorphic: true

      t.timestamps
    end

    add_index :follows, [:user_id, :followable_id, :followable_type], unique: true
  end
end
