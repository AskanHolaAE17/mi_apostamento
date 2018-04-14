class CreateErrorLives < ActiveRecord::Migration
  def change
    create_table :error_lives do |t|
      t.string   :error_title
      t.text     :error_description
      t.text     :notes
                
      t.timestamps                
    end
  end
end
