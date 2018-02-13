class ExperienceNotesController < ApplicationController
  before_action :authenticate_student!, except: [:index, :show]
  before_action :set_note,              only:   [:show, :edit, :update]
  before_action :published?,            only:   [:show, :edit, :update]
  before_action :set_period

  def index
    @notes = ExperienceNoteAdmin.order_publish_posts
  end

  def show
  end

  def new
    @note = current_user.experience_notes.build
  end

  def create
    @note = current_user.experience_notes.build(experience_note_params)
    if @note.save
      redirect_to timeline_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(experience_note_params)
      redirect_to timeline_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def set_note
    @note = ExperienceNote.find(params[:id])
  end

  def set_period
    @period = @note.try(:period) || params[:period] || 1
  end

  def published?
    forbidden unless @note.published_at.present? || staff_signed_in? 
  end

  def experience_note_params
    params
      .require(:experience_note)
      .permit(
        :user_id,
        :period,
        :situation,
        :reason,
        :change,
        :ambition,
        :published_at
       )
  end

end
