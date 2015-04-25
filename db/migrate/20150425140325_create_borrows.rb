class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.string :book_serial_no
      t.string :borrower_type
      t.integer :borrower_id
      t.datetime :borrow_date
      t.datetime :return_date
      t.boolean :is_return

      t.timestamps
    end
  end
end
