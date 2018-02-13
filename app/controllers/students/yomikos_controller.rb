class Students::YomikosController < ApplicationController
  before_action :set_student
  before_action :accessible?

  def index
    @yomikos = @student.yomikos.order(created_at: :desc)
  end

  def show
    @yomiko = Yomiko.find(params[:id])
  end

  def new
    @prev_yomiko = @student.yomikos.order(:created_at).last
    if @prev_yomiko.present?
      @yomiko = @student.yomikos.build(@prev_yomiko.attributes)
    else
      @yomiko = @student.yomikos.build
    end
  end

  def create
    @yomiko = @student.yomikos.build(yomiko_params.merge({ teacher_id: current_user.id }))
    if @yomiko.save
      redirect_to student_yomikos_path(@student)
    else
      render :new
    end
  end

  def edit
    @yomiko = Yomiko.find(params[:id])
  end

  def update
    @yomiko = Yomiko.find(params[:id])
    if @yomiko.update(yomiko_params)
      redirect_to student_yomikos_path(@student)
    else
      render :edit
    end
  end

  def destroy
    Yomiko.find(params[:id]).destroy
    redirect_to student_yomikos_path(@student)
  end

  private

  def accessible?
    forbidden unless staff_signed_in? ||
      (teacher_signed_in? && current_user.coaching?(@student))
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def yomiko_params
    params
      .require(:yomiko)
      .permit(
        :challenge,
        :yomiko,
        :first_choice,
        :second_choice,
        :condition,
        :memo,
      )
  end
end
