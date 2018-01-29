class RenameSecretQuestionInContacts < ActiveRecord::Migration
  def change
    remove_column    :contacts, :secret_questions, :string    
    add_column       :contacts, :secret_question, :string    
  end
end

