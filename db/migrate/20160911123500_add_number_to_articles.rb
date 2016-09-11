class AddNumberToArticles < ActiveRecord::Migration

  def change
    add_column  :articles, :number, :integer
  end
  
end

