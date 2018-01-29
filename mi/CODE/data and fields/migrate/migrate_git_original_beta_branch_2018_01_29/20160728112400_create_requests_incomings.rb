class CreateRequestsIncomings < ActiveRecord::Migration
  def change
    create_table :requests_incomings do |t|
      t.integer  :user_id
      t.string   :from
      t.string   :status
      t.boolean  :able, default: true      
                
      t.timestamps                
    end
  end
end
