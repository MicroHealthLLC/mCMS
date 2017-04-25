module Links
  class Link < ApplicationRecord
    belongs_to :user
    validates_presence_of :url, :user_id, :title
    before_save do
      self.hostname = URI.parse(url).hostname.sub(/^www\./, '')
    end
  end
end
