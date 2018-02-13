class Students::StudentReportsController < ApplicationController
  before_action :accessible?

  def index
    @student = Student.find(params[:student_id])
    @reports = @student.reports.order(date: :desc)
  end

  def show
    @student = Student.find(params[:student_id])
    @report  = StudentReport.find(params[:id])

    @prev_report = prev_report(@report.lesson.lesson_datetime)
    @prev_logs   = prev_logs(@report.lesson.lesson_datetime)
    @prev_study_time = @report.study_time.presence || prev_study_time(@report.lesson.lesson_datetime)
  end

  def new
    @student = Student.find(params[:student_id])
    @lesson  = Lesson.find(params[:lesson_id])
    @report  = @student.reports.new(lesson: @lesson)

    @prev_report = prev_report(@report.lesson.lesson_datetime)
    @prev_logs   = prev_logs(@lesson.lesson_datetime)
    @prev_study_time = prev_study_time(@lesson.lesson_datetime)
  end

  def create
    @student = Student.find(params[:student_id])
    @report =  @student.reports.new(student_report_params.merge(study_time: study_time))

    @lesson = Lesson.find(params[:lesson_id])
    @report.lesson  = @lesson

    @report.lesson = @lesson

    if @report.save
      # @report.auto_save_clear!(cookies)
      redirect_to student_student_reports_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:student_id])
    @report  = StudentReport.find(params[:id])
    @lesson  = Lesson.find(params[:lesson_id])

    @prev_report = prev_report(@report.lesson.lesson_datetime)
    @prev_logs   = prev_logs(@report.lesson.lesson_datetime)
    @prev_study_time = @report.study_time.presence || prev_study_time(@report.lesson.lesson_datetime)
  end

  def update
    @report = Lesson.find(params[:lesson_id]).student_report
    if @report.update(student_report_params.merge(study_time: study_time))
      # @report.auto_save_clear!(cookies)
      redirect_to student_student_reports_path, notice: t('.success')
    else
      render :edit
    end

  end

  private

  def study_time
    hour = params[:study_time_hour].presence || 0
    min  = params[:study_time_minute].presence || 0
    hour.to_i * 60 + min.to_i
  end

  def accessible?
    student = Student.find(params[:student_id])
    forbidden unless current_user == student || (teacher_signed_in? && current_user.coaching?(student)) || staff_signed_in?
  end

  def prev_report(day = Time.zone.now)
    @student
      .reports
      .includes(:lesson)
      .where('lessons.lesson_datetime > ? AND lessons.lesson_datetime < ?', day - 14.days, day)
      .references(:lesson)
      .order(date: :asc)
      .first
  end

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

  def student_report_params
    params
      .require(:student_report)
      .permit(
        :topic,
        :report,
        :keep,
        :problem,
        :trying,
        :review,
        :date,
        :image_id,
        images_images: [],
        images_attributes: [:id, :_destroy]
      )
  end
end
