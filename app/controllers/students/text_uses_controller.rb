class Students::TextUsesController < ApplicationController
  layout 'administrators'
  before_action :set_student
  before_action :accessible?

  def show
    @text_use = @student.text_use
  end

  def new
    @text_use = @student.build_text_use(content: template)
  end

  def create
    @text_use = @student.build_text_use(text_use_params)
    if @text_use.save
      redirect_to edit_student_text_use_path(@student), notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @text_use = @student.text_use
  end

  def update
    @text_use = @student.text_use
    if @text_use.update(text_use_params)
      redirect_to edit_student_text_use_path(@student), notice: t('.success')
    else
      render :edit
    end
  end

  private

  def accessible?
    forbidden unless staff_signed_in? ||
      (teacher_signed_in? && current_user.coaching?(@student))
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def text_use_params
    params
      .require(:text_use)
      .permit(
        :content
      )
  end

  def template
    template = <<EOL
メイン：

サブ：

サブサブ：

To Do：

Done：
EOL
    template
  end
end
