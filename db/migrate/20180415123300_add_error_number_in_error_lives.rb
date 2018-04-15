class AddErrorNumberInErrorLives < ActiveRecord::Migration


  def up
    add_column     :error_lives, :error_number, :integer
  end


  def down
    remove_column  :error_lives, :error_number
  end
  
  
end

