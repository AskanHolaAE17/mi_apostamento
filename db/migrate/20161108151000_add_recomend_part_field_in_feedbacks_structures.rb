class AddRecomendPartFieldInFeedbacksStructures < ActiveRecord::Migration

  def change
    add_column  :feedbacks_structures, :recomend_part, :text
  end
  
end

