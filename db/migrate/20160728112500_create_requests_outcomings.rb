class CreateRequestsOutcomings < ActiveRecord::Migration
  def change
    create_table :requests_outcomings do |t|
      t.integer  :user_id
      t.string   :to
      t.string   :status
      t.boolean  :able, default: true      
                
      t.timestamps                
    end
  end
end
