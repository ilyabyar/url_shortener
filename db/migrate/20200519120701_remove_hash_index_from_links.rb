class RemoveHashIndexFromLinks < ActiveRecord::Migration[6.0]
  def change
    remove_index :links, name: :index_links_on_url
  end
end
