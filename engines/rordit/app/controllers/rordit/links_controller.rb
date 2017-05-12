require 'uri'
module Rordit
  class LinksController < ApplicationController

    before_action  :authenticate_user!
    before_action :authorize, only: [:new, :create]
    before_action :get_links_count, only: [:get_newest_links, :get_popular_links]

    PER_PAGE = 10

    def index
    end

    def new
    end

    def edit
      @link = Link.find(params[:id])
    end

    def update
      link = Link.find(params[:id])
      params = {title: link_params[:title], url: link_params[:url], user_id: User.current.id,
                username: User.current.name,
                hostname: URI.parse(link_params[:url]).hostname.to_s.sub(/^www\./, '')}
      if link.update(params)
        Rails.cache.delete("links_count")
        render json: { message: links_path(link.id) }, status: 200
      else
        render json: { message: model_errors_json(link) }, status: 422
      end
    end

    def show
      @link = Link.find(params[:id])
    end

    def create
      link = Link.new(title: link_params[:title], url: link_params[:url], user_id: User.current.id,
                      username: User.current.name, hostname: URI.parse(link_params[:url]).hostname.sub(/^www\./, ''))
      if link.save
        Rails.cache.delete("links_count")
        render json: { message: links_path(link.id) }, status: 200
      else
        render json: { message: model_errors_json(link) }, status: 422
      end
    end

    def get_search_results
      search = link_params[:search].to_s.strip.split(' ')
      cond_url = []
      cond_title = []
      search.each do |s|
        cond_title<< "url LIKE '%#{s}%'"
        cond_url<< "title LIKE '%#{s}%'"
      end
      result = Link.where(nil)
      result = if search.present?
                 result.where("(#{cond_title.join(' OR ')}) OR (#{cond_url.join(' OR ')})")
               end
      paged_links = result.paginate(page: link_params[:page].to_i + 1, per_page: PER_PAGE)
      page_count = pages_count(result.count)
      render json: { links: paged_links.as_json, page_count: page_count }
    end

    def get_popular_links
      paged_links = Link.order("popularity DESC").paginate(page: link_params[:page].to_i + 1, per_page: PER_PAGE)
      render json: { links: paged_links.as_json, page_count: @page_count }
    end

    def get_newest_links
      paged_links = Link.order("created_at DESC").paginate(page: link_params[:page].to_i + 1, per_page: PER_PAGE)
      render json: { links: paged_links.as_json, page_count: @page_count }
    end

    def get_link
      @link = Link.find_by(id: link_params[:id])
      render json: @link.as_json
    end

    def destroy
      @link = Link.find_by(id: link_params[:id])
      @link.destroy if @link
      redirect_to '/rordit'
    end

    private

    def get_links_count
      links_count = Rails.cache.fetch("links_count") { Link.count }
      @page_count = pages_count(links_count)
    end

    def pages_count(count)
      if (count % PER_PAGE) == 0
        (count / PER_PAGE) - 1
      elsif (count / PER_PAGE) < 1
        0
      else
        (count / PER_PAGE)
      end
    end

    def link_params
      params.permit(:id, :utf8, :authenticity_token, :url, :title, :page, :search)
    end
    def model_errors_json(user)
      " #{user.errors.messages.first[0]} #{user.errors.messages.first[1][0].to_s}"
    end
  end
end
