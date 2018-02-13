class Students::ParentLogsController < ApplicationController
  layout 'administrators'
  before_action :authenticate_teacher!
  before_action :set_parameters

  def index
  end

  def new
    @log = ParentLog.new
  end

  def select
    @logs = (@student.parent_logs + @student.parent_greeting_logs).sort_by(&:created_at).reverse
  end

  def create
    @log = ParentLog.new(parent_log_params)
    @log.teacher      = @teacher
    @log.student      = @student
    @log.published_at = Time.zone.now if params[:draft].blank?
    if @log.save
      redirect_to select_student_parent_logs_path(@student)
    else
      render :new, lesson_id: params[:parent_log][:lesson_id]
    end
  end

  def edit
    @log = ParentLog.find(params[:id])
  end

  def update
    @log = ParentLog.find(params[:id])
    @log.published_at = params[:draft].blank? ? Time.zone.now : nil
    if @log.update(parent_log_params)
      redirect_to select_student_parent_logs_path(@student)
    else
      render :edit
    end
  end

  def destroy
    ParentLog.find(params[:id]).destroy
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

  def parent_log_params
    params
      .require(:parent_log)
      .permit(
        :lesson_id,
        :recent_news,
        :keep,
        :problem,
        :try,
        :question,
        :last_greeting,
        :comment,
        :parent,
        :relation,
        :lesson,
        :prevent_withdrawal,
        :exam_schools,
        :mindset,
      )
  end
end
