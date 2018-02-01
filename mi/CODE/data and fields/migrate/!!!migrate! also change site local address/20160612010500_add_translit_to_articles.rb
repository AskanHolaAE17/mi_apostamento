class AddTranslitToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :translit, :string
  end
end

