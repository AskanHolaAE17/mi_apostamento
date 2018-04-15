class AddErrorCodeInErrorLives < ActiveRecord::Migration


  def up
    add_column     :error_lives, :error_code, :integer
  end


  def down
    remove_column  :error_lives, :error_code
  end
  
  
end

