class ChangeIdTypeForBook < ActiveRecord::Migration
  def change
    change_column :books, :id, :string
  end
end
