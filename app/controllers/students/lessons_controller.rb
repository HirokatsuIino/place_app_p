class Students::LessonsController < ApplicationController
  before_action :set_student
  before_action :accessible?

  def index
    @lessons        = lessons
    @repeat_lessons = repeat_lessons
    @trial_test_logs  = @student.trial_test_logs.to_a.sort_by!(&:season).reverse
    @exam_school_logs = @student.exam_school_logs.to_a.sort_by!(&:exam_date).reverse
    @kakomon_logs     = @student.kakomon_logs.to_a.sort_by!(&:season).reverse

    @unread_exam_school_logs = []
    @unread_trial_test_logs  = []
    @unread_kakomon_logs     = []
    if current_user.teacher? && current_user.coaching?(@student)
      @exam_school_logs.each do |log|
        if log.read_at.nil?
          log.update(read_at: Time.zone.now)
          @unread_exam_school_logs << log.id
        end
      end

      @trial_test_logs.each do |log|
        if log.read_at.nil?
          log.update(read_at: Time.zone.now) unless log.carried_out
          @unread_trial_test_logs << log.id
        end
      end

      @kakomon_logs.each do |log|
        if log.read_at.nil?
          log.update(read_at: Time.zone.now) if log.impression.blank?
          @unread_kakomon_logs << log.id
        end
      end
    end

  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def accessible?
    forbidden unless staff_signed_in? ||
      current_user == @student ||
      (teacher_signed_in? && current_user.coaching?(@student))
  end

  def lessons
    LessonQuery.new
      .lessons
      .future
      .reserved
      .with_student(@student)
      .order(:lesson_datetime)
      .map(&:representative_lesson)
      .uniq
  end

  def repeat_lessons
    LessonQuery.new
      .repeat_parent_lessons
      .with_student(@student)
  end
end
