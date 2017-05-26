module Lms
  class AssignmentsController < ApplicationController
    before_action  :authenticate_user!
    before_action  :set_course
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    before_action :correct_teacher, only: [:edit, :update, :destroy]

    # GET /assignments
    def index
      @assignments = Assignment.where(teacher_id: User.current.id).all
    end

    # GET /assignments/1
    def show
    end

    # GET /assignments/new
    def new
      @assignment = User.current.assignments.build #Assignment.new
    end

    # GET /assignments/1/edit
    def edit
    end

    # POST /assignments
    def create
      @assignment = User.current.assignments.build(assignment_params)
      @assignment.course_id = @course.id

      respond_to do |format|
        if @assignment.save
          @assignment.delay.create_student_assignments!
          format.html { redirect_to lms.course_path(@assignment.course_id), notice: 'Assignment was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /assignments/1
    def update
      respond_to do |format|
        if @assignment.update(assignment_params)
          format.html { redirect_to lms.course_path(@assignment.course_id), notice: 'Assignment was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /assignments/1
    def destroy
      @assignment.destroy_student_assignments!
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to lms.course_path(@course), notice: 'Assignment was successfully destroyed.' }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = @course.assignments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_course
      @course = Lms::Course.find(params[:course_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def correct_teacher
      @assignment = User.current.assignments.find_by(id: params[:id])
      render_403 if @assignment.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:name, :body, :category, :course_id, :due_date, :teacher_id)
    end
  end
end
