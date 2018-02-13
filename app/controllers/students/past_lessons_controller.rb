class Students::PastLessonsController < ApplicationController
  before_action :authenticate_self!

  def index
    @student = Student.find(params[:student_id])
    @lessons = lessons
  end

  private

  def lessons
    LessonQuery.new
      .lessons
      .past
      .reserved
      .with_student(@student)
      .order(lesson_datetime: :desc)
      .map(&:representative_lesson)
      .uniq
  end
end
