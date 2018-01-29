class AddSecretAnswersToContacts < ActiveRecord::Migration
  def change
    add_column    :contacts, :secret_answer_1, :string    
    add_column    :contacts, :secret_answer_2, :string        
  end
end

