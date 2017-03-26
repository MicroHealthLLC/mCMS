module Rordit
  class PointsController < ApplicationController

    before_action  :authenticate_user!
    before_action :authorize

    def give_point_to_link
      give_point( { link_id: point_params[:link_id] } )
    end

    def give_point_to_comment
      give_point( { comment_id: point_params[:comment_id] } )
    end

    private

    def give_point(comment_or_link_id)
      if Point.exists?(comment_or_link_id.merge(user_id: User.current.id))
        render json: { message: "You've already gave point this." }, status: 422
      else
        point = Point.new(comment_or_link_id.merge(user_id: User.current.id))
        if point.save
          total = Point.where(comment_or_link_id).count
          render json: { totalPoint: total }, status: 200
        else
          render json: { message: "There is an error occurred." }, status: 422
        end
      end
    end

    def point_params
      params.permit(:link_id, :user_id, :comment_id)
    end
  end
end