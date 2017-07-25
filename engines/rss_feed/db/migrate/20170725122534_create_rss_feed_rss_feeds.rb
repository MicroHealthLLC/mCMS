class CreateRssFeedRssFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :rss_feed_rss_user_feeds do |t|
      t.integer :user_id
      t.text :rss_feed

      t.timestamps
    end
    add_index :rss_feed_rss_user_feeds, :user_id
  end
end
