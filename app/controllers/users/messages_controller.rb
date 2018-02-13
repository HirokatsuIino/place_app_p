class Users::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authenticate_access!,  only: :index
  before_action :authenticate_sending!, only: [:new, :create]
  after_action  :read!, only: :index

  def index
    @messages = messages
  end

  def new
    @message  = Message.new
    @messages = messages
  end

  def create
    @message = current_user.sent_messages.new(message_params.merge(to_user_id: @user ? @user.id : 0))
    if @message.save
      redirect_to user_inbox_path(current_user), notice: t('.success')
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find_by_id(params[:user_id])
  end

  def messages
    MessageQuery.new.inboxes(current_user, @user).order(created_at: :desc)
  end

  def read!
    MessageQuery.new.search.to(current_user).unread.find_each do |message|
      message.read!
    end
  end

  def authenticate_access!
    forbidden unless accessible?
  end

  def accessible?
    access_own_message_page? || current_user.staff? || messages.exists?
  end

  def authenticate_sending!
    forbidden unless sendable?
  end

  helper_method :sendable?
  def sendable?
    staff_signed_in? ||
      (access_senpre_message_page? && can?(:create, :dm_to_senpre))  ||
      (@user.student? && can?(:create, :dm_to_student)) ||
      (@user.teacher? && can?(:create, :dm_to_teacher))
  end

  helper_method :access_own_message_page?
  def access_own_message_page?
    current_user == @user
  end

  helper_method :access_senpre_message_page?
  def access_senpre_message_page?
    params[:user_id].to_i == 0
  end

  def message_params
    params
      .require(:message)
      .permit(
        :content,
        images_images: []
      )
  end
end
