class AddSecretQuestionsToContacts < ActiveRecord::Migration
  def change
    add_column    :contacts, :secret_questions, :string    
  end
end

