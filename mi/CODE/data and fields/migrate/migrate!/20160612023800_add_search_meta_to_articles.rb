class AddSearchMetaToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :description_meta, :string
    add_column :articles, :keywords_meta,    :string
    add_column :articles, :em,               :string
  end
end

