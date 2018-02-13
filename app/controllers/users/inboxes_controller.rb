class Users::InboxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authenticate_access!

  def show
    @messages = App::Headlines.new(@user).call
  end

  private

  def set_user
    @user = User.find_by_id(params[:user_id])
  end

  def authenticate_access!
    forbidden unless accessible?
  end

  def accessible?
    access_senpre_inbox? || access_own_inbox? || staff_signed_in?
  end

  helper_method :access_own_inbox?
  def access_own_inbox?
    current_user == @user
  end

  helper_method :access_senpre_inbox?
  def access_senpre_inbox?
    params[:user_id].to_i == 0
  end
end
