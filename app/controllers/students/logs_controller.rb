class Students::LogsController < ApplicationController
  before_action :authenticate_student!
  before_action :set_student

  def index
    @logs = @student.logs.order(day: :desc)
  end

  def show
    @log = StudentLog.find(params[:id])
  end

  def new
    @log         = @student.logs.new
    @last_report = @student.reports.last
  end

  def create
    @log = @student.logs.new(logs_params.merge(study_time: study_time))

    if @log.save
      @log.auto_save_clear!(cookies)
      redirect_to :root, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @log = StudentLog.find(params[:id])
  end

  def update
    @log = StudentLog.find(params[:id])

    if @log.update(logs_params.merge(study_time: study_time))
      @log.auto_save_clear!(cookies)
      redirect_to mypage_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    StudentLog.find(params[:id]).destroy
    redirect_to students_logs_path, notice: t('.deleted')
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def study_time
    return nil if params[:hour].blank? || params[:minute].blank?
    params[:hour].to_i * 60 + params[:minute].to_i
  end

  def logs_params
    params
      .require(:student_log)
      .permit(
        :content,
        :comment,
        :study_time,
        :day,
        :twitter_post,
        :twitter_comment,
        images_images: []
      )
  end
end
