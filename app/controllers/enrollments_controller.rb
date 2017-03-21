class EnrollmentsController < ApplicationController
  def new
    @user = current_user
    @course = Course.find_by(id: params[:format]) #this doesn't seem right but it works....
    if !user_already_enrolled?
      Enrollment.create(user_id: @user.id, course_id: @course.id)
      flash[:success] = "Sucessfully enrolled in course #{@course.code}"
      redirect_to @user
    else
      flash.now[:danger] = "Sorry, you're already enrolled in this course"
      #TODO: figure out how to re-render the current page 
    end
  end

  private
    def user_already_enrolled?
      !Enrollment.where(user_id: @user.id, course_id: @course.id).empty?
    end
end
