class Students::TutorLogsController < ApplicationController
  layout 'administrators'
  before_action :authenticate_teacher!
  before_action :set_parameters

  def index

  end

  def show
    @form = TutorLogForm.new(@student, @number, @log_id)

    if staff_signed_in?
      render :show and return
    else
      @item_master = TutorLogItemMaster.where(tutor_log_number: @number, textfield_required: true).order(:order)
      render :show_for_teacher and return
    end
  end

  def new
    @form = TutorLogForm.new(@student, @number, @log_id)
  end

  def create
    @form = TutorLogForm.new(@student, @number, @log_id)
    @form.teacher_id = current_user.id
    @form.draft = draft?
    if @form.save(tutor_log_params)
      notification_send!
      redirect_to tutor_logs_path
    else
      render :new
    end
  end

  def edit
    @form = TutorLogForm.new(@student, @number, @log_id)
  end

  def update
    @form = TutorLogForm.new(@student, @number, @log_id)
    @form.draft = draft?
    if @form.update(tutor_log_params)
      notification_send!
      redirect_to tutor_logs_path
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def draft?
    params[:draft_button].present?
  end

  def notification_send!
    log = TutorLog.find_by(
        student_id: @student.id,
        number:     @number
    )
    return unless log
    unless draft?
      if !log.notification_sent
        if log.interview_log?
          message = "サポーター #{log.teacher.nickname}さんが生徒 #{log.student.nickname}さんのサポーター面談ログを作成しました"
        else
          message = "サポーター #{log.teacher.nickname}さんが生徒 #{log.student.nickname}さんのガイダンス #{log.number} 回目を実施、ガイダンスログを作成しました"
        end
        message += "\n"
        message += "[詳細をみる](#{student_tutor_log_url(log.student, log.number, log)})"
        message = Slack::Notifier::Util::LinkFormatter.format(message)
        SlackNotifier.notify('#r3-seito-support', message, ':memo:')
        TutorLogMailer.email(@student, @number).deliver_now

        if log.log_level.lesson_level == 1
          teacher = current_user.nickname
          student = @student.nickname
          message = "生徒 #{student}さんがサポーター #{teacher}さんのガイダンスで「指導の受け方レベル」1と判定されました"
          SlackNotifier.notify('#r3-seito-support', message, ':warning:')
        end
        log.update_attribute(:notification_sent, true)
      end
    end

    log.update_attribute(:notification_sent, draft?)
  end

  def set_parameters
    @student = Student.find(params[:student_id])
    @teacher = current_user
    @number  = params[:number].to_i
    @lessons = lessons
    @log_id  = params[:id].to_i
  end

  def lessons
    LessonQuery.new
      .lessons
      .reserved
      .with_student(@student)
      .order(lesson_datetime: :desc)
      .map(&:representative_lesson)
      .uniq
  end

  def tutor_log_params
    params
      .require(:tutor_log)
      .permit(
        :draft_button,
        :cycle_level,
        :lesson_level,
        :log_level,
        :report_level,
        *TutorLogForm.attributes
      )
  end

end
