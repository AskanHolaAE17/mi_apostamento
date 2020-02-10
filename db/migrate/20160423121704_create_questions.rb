class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer  "number_of_question"
      t.string   "title"
      t.integer  "test_id"
      t.boolean  "able",                           default: true
      t.string   "for_yes_answer_plus_1_point_to"
                
      t.timestamps                
    end
  end
end
