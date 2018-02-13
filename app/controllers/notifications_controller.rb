class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action  :read!, only: :index

  def index
    @notifications = notifications
  end

  private

  def notifications
    notifications = current_user.notifications.order(created_at: :desc).limit(100)
    notifications.to_a.reject { |notification| !notification.clean? }
  end

  def read!
    NotificationQuery.new(current_user.notifications).search.unread.find_each do |notification|
      notification.read!
    end
  end
end
