class Students::ProfilesController < ApplicationController
  before_action :set_student
  before_action :accessible?

  def index
    @profiles   = StudentProfile.where(student_id: @student)
    @interviews = interviews
  end

  def show
    @profile    = @student.profile
    @interviews = interviews
  end

  def new
    @profile = @student.build_profile(free_content: free_content)
  end

  def create
    @profile = @student.create_profile(profile_params)

    if @profile.save
      redirect_to student_profile_path(@student), notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @profile = @student.profile
  end

  def update
    @profile = @student.profile

    if @profile.update(profile_params)
      redirect_to student_profile_path(@student), notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @student.profile.destroy
    redirect_to student_profile_path
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def accessible?
    forbidden unless current_user == @student ||
      (teacher_signed_in? && current_user.coaching?(@student)) ||
      admin_signed_in? ||
      customer_success_signed_in?
  end

  def interviews
    (InterviewLog.where(student_id: @student) + AfterInterviewLog.where(student_id: @student)).sort_by(&:updated_at).reverse
  end

  def profile_params
    params
      .require(:student_profile)
      .permit(
        :content,
        :free_content,
        student_profile_item_attributes: [
          :id,
          :student_profile_id,
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
        ]
      )
  end

  def free_content
    content = <<-EOS
・志望校 / 学部：
・志望校を決めた理由：
・現在の目標：
・趣味・好きなこと：
・学校名（浪人生は卒業校）：
・現在の学年：
・文系or理系：
・部活やバイト：
・塾や習い事：
・解決したい悩み・課題：
・得意教科：
・苦手教科：
・【最新の模試について】（例→全統マーク模試 6月：55）
  模試名＋時期：
  総合偏差値：
・【学校内での学力レベル】（※以下で当てはまるものに○してください）
   上：
   中の上：
  中の下：
  下の上：
  下の下：
  EOS
  content
  end
end
