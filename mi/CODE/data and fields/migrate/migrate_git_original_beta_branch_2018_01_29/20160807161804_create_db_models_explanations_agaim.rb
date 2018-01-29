class CreateDbModelsExplanationsAgaim < ActiveRecord::Migration
  def change
    create_table :db_models_explanations do |t|
    
      t.string   :the_model_name
      t.text     :common_info
      t.text     :details

      t.timestamps null: false
    end
  end
end


