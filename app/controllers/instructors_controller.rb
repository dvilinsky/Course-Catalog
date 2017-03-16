class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.paginate(page: params[:page])
  end
end
