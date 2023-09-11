class RenameBookAmmountToBookAmountInBooks < ActiveRecord::Migration[7.0]
  def change
    rename_column :books, :book_ammount, :book_amount 
  end
end
