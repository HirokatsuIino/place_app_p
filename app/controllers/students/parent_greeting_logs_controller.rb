class Students::ParentGreetingLogsController < ApplicationController
  layout 'administrators'
  before_action :authenticate_teacher!
  before_action :set_parameters

  def new
    @log = ParentGreetingLog.new
  end

  def create
    @log = ParentGreetingLog.new(parent_greeting_log_params)
    @log.teacher = @teacher
    @log.student = @student
    @log.published_at = Time.zone.now if params[:draft].blank?
    if @log.save
      redirect_to select_student_parent_logs_path(@student)
    else
      render :new
    end
  end

  def edit
    @log = ParentGreetingLog.find(params[:id])
  end

  def update
    @log = ParentGreetingLog.find(params[:id])
    @log.published_at = params[:draft].blank? ? Time.zone.now : nil
    if @log.update(parent_greeting_log_params)
      redirect_to select_student_parent_logs_path(@student)
    else
      render :edit
    end
  end

  def destroy
    ParentGreetingLog.find(params[:id]).destroy
    redirect_to select_student_parent_logs_path(@student)
  end

  private

  def set_parameters
    @student = Student.find(params[:student_id])
    @teacher = current_user
  end

  helper_method :prev_study_time
  def prev_study_time(day = Time.zone.now)
    sum = 0
    prev_logs(day).each do |h|
      logs = h[:logs]
      sum = sum + (logs.present? ? logs.inject(0) { |s, log| s + log.study_time.to_i } : 0)
    end
    sum
  end

  def prev_logs(day = Time.zone.now)
    from = (day - 1.week).to_date
    to   = day.to_date
    (from...to).map do |date|
      {
        date: date,
        logs: StudentLogQuery.new(@student.logs).search.at_the_day(date)
      }
    end.sort_by { |h| h[:date] }.reverse
  end

  def parent_greeting_log_params
    params
      .require(:parent_greeting_log)
      .permit(
        :working_reason,
        :coaching_reason,
        :experience,
        :student_impression,
        :about_student,
        :announce,
        :team,
        :about_interview,
        :parent,
        :relation,
        :lesson,
        :prevent_withdrawal,
        :exam_schools,
        :mindset,
      )
  end
end
