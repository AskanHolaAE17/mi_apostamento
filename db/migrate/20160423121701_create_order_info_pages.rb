class CreateOrderInfoPages < ActiveRecord::Migration
  def change
    create_table :order_info_pages do |t|
      t.string   :title
      t.text     :msg
      t.string   :translit

      t.timestamps null: false
    end
  end
end
