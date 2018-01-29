class CreateTestTargetServicesAgain1 < ActiveRecord::Migration
  def change
    create_table :test_target_services do |t|
      
      t.string   :title
      t.text     :body
      t.integer  :number
      t.boolean  :active,       default: true 

      t.timestamps null: false
    end
  end
end


