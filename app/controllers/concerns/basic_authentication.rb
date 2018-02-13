module BasicAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :basic_authenticate
  end

  private

  def basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
