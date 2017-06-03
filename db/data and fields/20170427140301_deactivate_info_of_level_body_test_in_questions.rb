class DeactivateInfoOfLevelBodyTestInQuestions < ActiveRecord::Migration

  
  @questions = Question.all   
  
  @questions.where(number_of_question: '5').update_all able: false
  
  @questions.where(number_of_question: '8').update_all able: false
  
  

end

