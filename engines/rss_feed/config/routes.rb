RssFeed::Engine.routes.draw do
  get 'rss/index'
  get 'rss/save'
  root to:'rss#index'
end