class UploadShortLevelResToQuestions < ActiveRecord::Migration
  

  Question.all.where(test_id: '2').each do |f|
  
    if f.for_yes_answer_plus_1_point_to == 'nevrot' 
      f.update_attribute :for_yes_answer_plus_1_point_to, 'n'
    end
    
    if f.for_yes_answer_plus_1_point_to == 'pogranich' 
      f.update_attribute :for_yes_answer_plus_1_point_to, 'p'
    end

    if f.for_yes_answer_plus_1_point_to == 'psihot' 
      f.update_attribute :for_yes_answer_plus_1_point_to, 'ps'
    end
    
  end
  
end

