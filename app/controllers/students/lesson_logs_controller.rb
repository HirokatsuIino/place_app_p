class Students::LessonLogsController < ApplicationController
  before_action :set_student
  before_action :accessible?

  def index
    @logs    = TeacherLog.find(params[:id]).order(created_at: :desc)
  end

  def show
    @log = TeacherLog.find(params[:id])
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def accessible?
    forbidden unless current_user == @student ||
      admin_signed_in? ||
      customer_success_signed_in? ||
      (teacher_signed_in? && current_user.coaching?(@student))
  end

  def template
    template = <<-EOD
  【指導前】
  ・

  ＜👍＞★
  ・

  ＜前回TDL＞

  ＜前回KPTM＞

  【指導中】
  ＜アジェンダ／相談したいこと＞
  ・

  ＜聞いたこと／話したこと＞
  ・

  ＜TDL>
  ・

  【指導後KPTM】
  ＜KEEP＞
  ・
  ＜PROBLEM＞
  ・
  ＜TRY＞
  ・
  ＜MEMO＞
  ・"

    EOD
    template
  end

  def logs_params
    params
      .require(:teacher_log)
      .permit(
        :teacher_id,
        :student_id,
        :lesson_id,
        :log_content,
        :saved_content,
        :self_score,
        images_images: []
      )
  end
end
