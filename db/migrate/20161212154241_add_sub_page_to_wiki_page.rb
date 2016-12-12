class AddSubPageToWikiPage < ActiveRecord::Migration[5.0]
  def change
    add_column :wiki_pages, :sub_page_id, :integer
  end
end
