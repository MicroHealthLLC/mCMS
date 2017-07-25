module RssFeed
  class RssUserFeed < ApplicationRecord
    validates_presence_of :user_id
  end
end
