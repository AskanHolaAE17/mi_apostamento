class UploadStructuresCounterToQuestions < ActiveRecord::Migration
  
  
  @count = 1
  Question.all.where(test_id: '1').each do |f|
    f.update_attribute :number_of_question, @count
    @count = @count + 1
  end
  
end

