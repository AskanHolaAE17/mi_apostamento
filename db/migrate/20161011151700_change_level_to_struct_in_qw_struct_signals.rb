class ChangeLevelToStructInQwStructSignals < ActiveRecord::Migration
  def change
    rename_column :qw_struct_signals, :level, :struct    
  end
end

