class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :book_type
      t.string :book_type_category
      t.string :serial_no
      t.integer :count
      t.string :edition
      t.string :book_author
      t.string :book_publisher
      t.integer :thesis_id

      t.timestamps
    end
  end
end
