class AddAllInfoToQuestions < ActiveRecord::Migration

  Question.all.each do |f|
    f.update_attribute :test_id, '1'
  end
  
  @count = 1
  Question.all.each do |f|
    f.update_attribute :number_of_question, @count
    @count = @count + 1
  end

end

