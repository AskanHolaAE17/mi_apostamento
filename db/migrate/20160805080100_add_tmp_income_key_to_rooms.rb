class AddTmpIncomeKeyToRooms < ActiveRecord::Migration
  def change
    add_column  :rooms, :tmp_income_key, :string    
  end
end

