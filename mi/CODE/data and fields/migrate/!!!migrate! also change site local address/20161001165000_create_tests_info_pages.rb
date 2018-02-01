class CreateTestsInfoPages < ActiveRecord::Migration
  def change
    create_table :tests_info_pages do |t|
      t.string   :title
      t.text     :msg
      t.string   :translit

      t.timestamps null: false
    end
  end
end
