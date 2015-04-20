class AddIsShowToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :isShow, :boolean
  end
end
