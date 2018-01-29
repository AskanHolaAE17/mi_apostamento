class SetDefaultFontSizeInRooms < ActiveRecord::Migration
  def change
    change_column :rooms, :font_size, :string, default: '1'
  end
end

