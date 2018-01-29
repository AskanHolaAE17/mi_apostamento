class AddNumberToPreambleElements < ActiveRecord::Migration

  def change
    add_column  :preamble_elements, :number, :integer
  end
  
end

