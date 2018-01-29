class CreateMeConstants < ActiveRecord::Migration
  def change
    create_table :me_constants do |t|
      t.string   "title"
      t.string   "content"
            
      t.timestamps                
    end
  end
end
