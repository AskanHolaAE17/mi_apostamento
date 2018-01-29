class AddLinkIfUnsavedToConsultsAgain < ActiveRecord::Migration
  def change
    add_column :consults, :link_if_unsaved, :string
  end
end

