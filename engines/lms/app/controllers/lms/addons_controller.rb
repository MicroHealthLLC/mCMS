module Lms
  class AddonsController < ApplicationController
    before_action  :authenticate_user!
    before_action :set_course
    before_action :teacher_course

    # POST /courses/1/add_link
    def add_link
      name = params[:course_link][:name]
      url = params[:course_link][:url]
      @course_link = Lms::CourseLink.new(name: name, url: url, course_id: @course.id)
      if @course_link.save
        flash[:alert] = "Link saved!"
        redirect_to lms.course_path(@course)
      else
        flash[:alert] = "The link did not save properly."
      end
    end

    # DELETE /courses/1/delete_link/1
    def delete_link
      @course_link = Lms::CourseLink.find(params[:link_id])

      @course_link.destroy
      flash[:alert] = "Link deleted!"
      redirect_to lms.course_path(@course)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def teacher_course
      @course = User.current.courses.find_by(id: params[:id])
      render_403 if @course.nil?
    end
  end
end
