ActionMailer::Base.register_observer(EmailObserver) unless Rails.env.development?
