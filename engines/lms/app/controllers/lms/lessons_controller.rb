module Lms
  class LessonsController < ApplicationController
    before_action  :authenticate_user!
    before_action :set_course
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    # GET /lessons
    def index
      @lessons = @course.lessons
    end

    # GET /lessons/1
    def show
      @comments = @lesson.comments.order('id DESC')
    end

    # GET /lessons/new
    def new
      @lesson = Lesson.new(course_id: @course.id, user_id: User.current.id)
    end

    # GET /lessons/1/edit
    def edit
    end

    # POST /lessons
    def create
      @lesson = Lesson.new(lesson_params)

      if @lesson.save
        redirect_to lms.course_lesson_path(@course, @lesson), notice: 'Lesson was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /lessons/1
    def update
      if @lesson.update(lesson_params)
        redirect_to lms.course_lesson_path(@course, @lesson) , notice: 'Lesson was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /lessons/1
    def destroy
      @lesson.destroy
      redirect_to lms.course_path(@course), notice: 'Lesson was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_lesson
        @lesson = @course.lessons.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_404
      end

    def set_course
      @course = Lms::Course.find(params[:course_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

      # Only allow a trusted parameter "white list" through.
      def lesson_params
        params.require(:lesson).permit(Lms::Lesson.safe_attributes)
      end
  end
end
