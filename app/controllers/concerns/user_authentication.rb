module UserAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :teacher_signed_in?
    helper_method :student_signed_in?
    helper_method :staff_signed_in?
    helper_method :admin_signed_in?
    helper_method :customer_success_signed_in?

    helper_method :forbidden
    def forbidden
      raise ApplicationController::Forbidden.new('Forbidden')
    end

    helper_method :not_found
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

  end

  private

  def teacher_signed_in?
    user_signed_in? && current_user.teacher?
  end

  def student_signed_in?
    user_signed_in? && current_user.student?
  end

  def staff_signed_in?
    admin_signed_in? || customer_success_signed_in?
  end

  def admin_signed_in?
    user_signed_in? && (current_user.admin? || current_user.pm?)
  end

  def customer_success_signed_in?
    user_signed_in? && current_user.customer_success?
  end

  def authenticate_student!
    forbidden unless student_signed_in? || staff_signed_in?
  end

  def authenticate_teacher!
    forbidden unless teacher_signed_in? || staff_signed_in?
  end

  def authenticate_staff!
    forbidden unless admin_signed_in? || customer_success_signed_in?
  end

  def authenticate_admin!
    forbidden unless admin_signed_in?
  end

  def authenticate_customer_success!
    forbidden unless customer_success_signed_in? || admin_signed_in?
  end

  def authenticate_self!
    forbidden unless user_signed_in?
    return if admin_signed_in?

    if params[:user_id]
      user = User.find(params[:user_id])
    else
      user = teacher_signed_in? ? User.find(params[:teacher_id]) : User.find(params[:student_id])
    end

    forbidden unless current_user == user
  end
end
