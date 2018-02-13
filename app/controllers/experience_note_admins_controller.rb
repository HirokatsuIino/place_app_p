class ExperienceNoteAdminsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @note = ExperienceNoteAdmin.find(params[:id])
  end
  
end