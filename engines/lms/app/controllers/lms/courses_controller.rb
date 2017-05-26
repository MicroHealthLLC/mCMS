module Lms
  class CoursesController < ApplicationController
    before_action  :authenticate_user!
    before_action :set_course, only: [:show, :edit, :update, :destroy]
    before_action :correct_teacher, only: [:edit, :update, :destroy]
    before_action :course_student, only: [:show]

    # GET /courses
    def index
      @courses = Lms::Course.all
    end

    # GET /courses/1
    def show
      @assignments = @course.assignments
      @course_links = @course.course_links
      @course_files = @course.course_files
    end

    # GET /courses/new
    def new
      @course = User.current.courses.build
    end

    # GET /courses/1/edit
    def edit
    end

    # POST /courses
    def create
      @course = User.current.courses.build(course_params)

      respond_to do |format|
        if @course.save
          format.html { redirect_to @course, notice: 'Course was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /courses/1
    def update
      respond_to do |format|
        if @course.update(course_params)
          format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /courses/1
    def destroy
      @course.destroy
      respond_to do |format|
        format.html { redirect_to lms.courses_url, notice: 'Course was successfully destroyed.' }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def correct_teacher
      @course = User.current.courses.find_by(id: params[:id])
      render_403 if @course.nil?
    end

    def course_student
      if User.current.is_student?
        @course = User.current.student_courses.find_by(id: params[:id])
        render_403 if @course.nil?
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(Lms::Course.safe_attributes)
    end
  end
end
