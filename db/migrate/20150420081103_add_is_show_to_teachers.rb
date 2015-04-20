class AddIsShowToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :isShow, :boolean
  end
end
