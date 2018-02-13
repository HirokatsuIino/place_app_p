class Students::StudentsController < ApplicationController
  include Timelinable

  before_action :set_student

  def show
    @teacher_logs = teacher_logs

    @duration = 1.month.ago..Time.zone.now
    @duration = (@duration.begin + 1.day).to_date..@duration.end.to_date

    render_timeline
  end

  private

  def teacher_logs
    @student.teacher_logs.order(created_at: :desc)
    #if staff_signed_in?
    #  @student.teacher_logs.order(created_at: :desc)
    #elsif current_user.teacher?
    #  @student.teacher_logs.where(teacher_id: current_user).order(created_at: :desc)
    #end
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def posts
    posts = PostQuery.new.search.with_poster(@student)
    posts = posts.where.not(post_content_type: 'TeacherLog', id: [Reply.for_teacher_log, Reply.for_reply_to_teacher_log, Repost.for_teacher_log].flatten.map(&:post))
    posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def type
    current_user.type.downcase
  end
end
