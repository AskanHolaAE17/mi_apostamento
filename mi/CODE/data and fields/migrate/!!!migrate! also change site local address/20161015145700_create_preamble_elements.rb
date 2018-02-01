class CreatePreambleElements < ActiveRecord::Migration
  def change
    create_table  :preamble_elements do |t|

      t.string     :name
      t.text       :body

      t.timestamps null: false
    end
  end
end


