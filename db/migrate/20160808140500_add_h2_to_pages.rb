class AddH2ToPages < ActiveRecord::Migration

  def change
    add_column  :pages, :h2, :string
  end
  
end

