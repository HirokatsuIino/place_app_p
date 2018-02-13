class Students::InterviewLogsController < ApplicationController
  layout 'administrators'
  before_action :set_student
  before_action :accessible?

  def show
    @log     = InterviewLog.find(params[:id])
    @profile = @log.teacher_edit_student_profile
  end

  def new
    @log = @student.interview_logs.new
    @log.teacher = current_user
    @profile = current_user.teacher_edit_student_profiles.new(student: @student, interview_log: @log, student_profile: @student.profile)
    if old_student_profile_format?
      @profile.content = @student.profile.free_content
    else
      attributes = @student.profile ? @student.profile.student_profile_item.attributes.except('student_profile_id') : nil
      @profile.build_teacher_edit_student_profile_item(attributes)
    end
  end

  def create
    @log = @student.interview_logs.new(interview_log_params)
    @log.teacher = current_user
    if old_student_profile_format?
      @profile = current_user.teacher_edit_student_profiles.new(teacher_edit_student_profile_params.merge({student: @student, interview_log: @log, student_profile: @student.profile}))
      if @log.save && @profile.save
        redirect_to student_profile_path(@student), notice: '前面談ログを作成しました。'
      else
        render :new
      end
    else
      @profile = current_user.teacher_edit_student_profiles.new(student: @student, interview_log: @log, student_profile: @student.profile)
      @profile.build_teacher_edit_student_profile_item(teacher_edit_student_profile_item_params)
      if @log.save && @profile.save && @profile.teacher_edit_student_profile_item.save
        redirect_to student_profile_path(@student), notice: '前面談ログを作成しました。'
      else
        render :new
      end
    end
  end

  def edit
    @log     = InterviewLog.find(params[:id])
    @profile = @log.teacher_edit_student_profile
  end

  def update
    @log     = InterviewLog.find(params[:id])
    @profile = @log.teacher_edit_student_profile

    if old_student_profile_format?
      if @log.update(interview_log_params)
        @profile.update(teacher_edit_student_profile_params) unless old_interview_log_format?
        redirect_to student_profile_path(@student), notice: '前面談ログを編集しました。'
      else
        render :edit
      end
    else
      if @log.update(interview_log_params)
        @profile.teacher_edit_student_profile_item.update(teacher_edit_student_profile_item_params) unless old_interview_log_format?
        redirect_to student_profile_path(@student), notice: '前面談ログを編集しました。'
      else
        render :edit
      end
    end
  end

  private

  helper_method :old_student_profile_format?
  def old_student_profile_format?
    @student.profile && !@student.profile.student_profile_item
  end

  helper_method :old_interview_log_format?
  def old_interview_log_format?
    @log && !@log.interview_log_item
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def accessible?
    forbidden unless (teacher_signed_in? && current_user.coaching?(@student)) || staff_signed_in?
  end

  def interview_log_params
    params
      .require(:interview_log)
      .permit(
        :student_id,
        :content,
        interview_log_item_attributes: [
          :id,
          :interview_log_id,
          :how_to_know,
          :why,
          :expectation,
          :family_preferred_school,
          :family_study,
          :family_times,
          :understand,
          :trial_date,
          :comment,
          :problem,
          :transmission,
          :memo
        ]
      )
  end

  def teacher_edit_student_profile_params
    params
      .require(:teacher_edit_student_profile)
      .permit(
        :content
      )
  end

  def teacher_edit_student_profile_item_params
    params
      .require(:teacher_edit_student_profile_item)
      .permit(
        :preferred_school,
        :preferred_school_reason,
        :school,
        :grade,
        :study_type,
        :hobby,
        :club,
        :learning,
        :goal,
        :problem,
        :subjects,
        :favorite_subjects,
        :dislike_subjects,
        :test,
        :comment,
        :level,
      )
  end

end
