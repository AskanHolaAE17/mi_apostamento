class AddDefaultValueForSumInUserSites < ActiveRecord::Migration


  def up
    change_column :user_sites, :common_sum, :decimal, default: 0
  end


  def down
    change_column :user_sites, :common_sum, :decimal, default: nil
  end
  
  
end

