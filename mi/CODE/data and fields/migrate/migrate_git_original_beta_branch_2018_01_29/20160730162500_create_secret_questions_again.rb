class CreateSecretQuestionsAgain < ActiveRecord::Migration
  def change
    create_table :secret_questions do |t|
    
      t.text     :body      
                
      t.timestamps                
    end
  end
end


