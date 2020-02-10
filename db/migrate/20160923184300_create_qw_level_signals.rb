class CreateQwLevelSignals < ActiveRecord::Migration
  def change
    create_table :qw_level_signals do |t|

      t.integer  :qw_number
      t.text     :field
      t.string   :level
      t.boolean  :able,       default: true 

      t.timestamps null: false
    end
  end
end


