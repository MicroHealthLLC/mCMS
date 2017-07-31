require_dependency "rss_feed/application_controller"

module RssFeed
  class RssController < ApplicationController
    include RssFeed::RssHelper
    before_action  :authenticate_user!
    def index
      @rss = RssFeed::RssUserFeed.where(user_id: User.current.id).first_or_initialize
    end

    def save
      @rss = RssFeed::RssUserFeed.where(user_id: User.current.id).first_or_initialize
      @rss.rss_feed = params[:content]
      @rss.save
      render json: {success: true}
    end

  end
end
