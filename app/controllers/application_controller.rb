class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end

  include BasicAuthentication if Rails.env.staging?
  include UserAuthentication

  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :set_unread_notification_count
  before_action :set_unread_message_count

  helper_method :authenticate!
  def authenticate!(*args)
    forbidden if current_ability.cannot?(*args)
  end

  helper_method :can?
  def can?(*args)
    current_ability.can?(*args)
  end

  helper_method :cannot?
  def cannot?(*args)
    current_ability.cannot?(*args)
  end

  def after_sign_up_path_for(resource)
    if resource.teacher?
      registration_wizard_path(:step1)
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    return root_path if resource.active?

    if resource.teacher?
      registration_wizard_path(:step1)
    elsif resource.student?
      registration_wizard_path(:step3)
    end
  end

  private

  def current_ability
    @current_ability ||= if user_signed_in?
                           Ability.new(current_user)
                         else
                           Ability.new(nil)
                         end
  end

  helper_method :content_only?
  def content_only?
    controller_name == 'pages' ||
      (devise_controller? && action_name != 'edit') ||
      controller_name == 'registrations' ||
      controller_name == 'reviews'
  end

  def set_unread_notification_count
    @unread_notification_count = if user_signed_in?
                                   NotificationQuery.new.search.unread.to(current_user).count
                                 else
                                   0
                                 end
  end

  def set_unread_message_count
    @unread_message_count = if user_signed_in?
                              MessageQuery.new.search.unread.to(current_user).count
                            else
                              0
                            end
  end
end
