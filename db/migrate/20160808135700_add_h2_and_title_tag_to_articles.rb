class AddH2AndTitleTagToArticles < ActiveRecord::Migration

  def change
    add_column  :articles, :h2, :string
    add_column  :articles, :title_tag, :string
  end
  
end

