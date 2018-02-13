module TeacherBasicAuthentication
  extend ActiveSupport::Concern

  def basic_authenticate
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'senseiplaceteachers' && pass == 'changeeducation'
    end
  end
end
