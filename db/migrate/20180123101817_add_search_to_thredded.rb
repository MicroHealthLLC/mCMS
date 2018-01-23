class AddSearchToThredded < ActiveRecord::Migration[5.0]
  def change
    DbTextSearch::FullText.add_index connection, :thredded_topics, :title, name: :thredded_topics_title_fts
    DbTextSearch::FullText.add_index connection, :thredded_posts, :content, name: :thredded_posts_content_fts
  end
end
