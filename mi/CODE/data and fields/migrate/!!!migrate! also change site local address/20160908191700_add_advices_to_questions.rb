class AddAdvicesToQuestions < ActiveRecord::Migration

  def change
    add_column  :questions, :advice, :text
  end
  
end

