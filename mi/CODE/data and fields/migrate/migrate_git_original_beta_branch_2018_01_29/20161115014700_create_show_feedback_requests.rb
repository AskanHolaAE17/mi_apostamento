class CreateShowFeedbackRequests < ActiveRecord::Migration
  def change
    create_table :show_feedback_requests do |t|
      t.integer  :user_id
      t.string   :asker
      t.string   :receiver
      t.string   :status
      t.boolean  :able, default: true      
                
      t.timestamps                
    end
  end
end
