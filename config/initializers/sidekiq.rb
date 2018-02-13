if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 9 }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 1 }
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379' }
  end
end
