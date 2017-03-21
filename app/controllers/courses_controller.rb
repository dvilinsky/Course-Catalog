class CoursesController < ApplicationController
  def index
    @courses = Course.paginate(page: params[:page])
  end

  def new_search
  end

  def search
    @subject = params[:subject_id]
    @code = params[:course_name]
    if @subject.blank? && !@code.blank?
      #puts singular course result into an array
      @courses = [Course.find_by(code: @code)]
    elsif !@subject.blank? && @code.blank?
      #gives "the moral equivalent of" an array
      @courses = Subject.find_by(id: @subject).courses
    elsif @subject.blank? && @code.blank?
      flash.now[:danger] = "Error: Both fields can't be blank"
      render 'new_search'
    else
      @course = Subject.find_by(id: @subject).courses.find_by(code: @code)
      if @course.nil?
        flash.now[:warning] = "No such #{Subject.find_by(id:@subject).name} course with that code"
        render 'new_search'
      end
    end
  end
end
