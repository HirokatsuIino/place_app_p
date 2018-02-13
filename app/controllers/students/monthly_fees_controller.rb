class Students::MonthlyFeesController < ApplicationController
  before_action :authenticate_self!

  def index
    @student = Student.find(params[:student_id])
  end
end
