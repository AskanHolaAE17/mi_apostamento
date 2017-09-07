class AddArticleNumberToPreambleElements < ActiveRecord::Migration

  def change
    add_column  :preamble_elements, :article_number, :integer
  end
  
end

