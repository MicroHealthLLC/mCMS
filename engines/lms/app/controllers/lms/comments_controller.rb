module Lms
  class CommentsController < ApplicationController
    before_action  :authenticate_user!
    before_action :set_course
    before_action :set_lesson

    def create
      @comment = Lms::Comment.new(comment_params)
      @comment.lesson_id = @lesson.id
      @comment.user_id = User.current.id
      if @comment.save
        respond_to do |format|
          format.html {redirect_to lms.course_lesson_path(@course, @lesson)}
          format.js{}
        end
      end
    end

    def destroy
      @comment = @lesson.comments.find params[:id]
      @comment.destroy
    end

    private
    def set_course
      @course = Lms::Course.find params[:course_id]
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_lesson
      @lesson = @course.lessons.find params[:lesson_id]
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def comment_params
      params.require(:comment).permit(Lms::Comment.safe_attributes)
    end
  end
end
