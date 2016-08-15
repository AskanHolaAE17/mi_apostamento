class CreateFeedbacksStructures < ActiveRecord::Migration
  def change
    create_table :feedbacks_structures do |t|

      t.string   :title
      t.text     :body

      t.timestamps null: false
    end
  end
end


