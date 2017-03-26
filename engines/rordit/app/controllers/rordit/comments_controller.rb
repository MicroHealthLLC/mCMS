module Rordit
  class CommentsController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize, only: :new

    def new
      comment = Comment.new(comment: comment_params[:comment], link_id: comment_params[:link_id], user_id: User.current.id,
                            username: User.current.name)
      if comment.save
        render json: { message: links_path(comment_params[:link_id]) }, status: 200
      else
        render json: "There is an error occurred.", status: 422
      end
    end

    def get_comments
      @comments = Comment.where(link_id: comment_params[:link_id])
      render json: { comments: @comments.as_json }
    end

    private

    def comment_params
      params.permit(:comment, :link_id, :user_id)
    end
  end
end
