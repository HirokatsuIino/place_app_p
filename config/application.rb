require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Senseiplace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Tokyo'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Use the Rails default middleware stack.
    config.api_only = false

    config.assets.precompile += %w(*.eot *.svg *.ttf *.woff *.jpeg *.jpg)

    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/app/queries/lessons
    )

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html = html_tag.html_safe
      else
        method_name = instance.instance_variable_get(:@method_name)
        errors = instance.object.errors.full_messages_for(method_name.to_sym)
        if errors.any?
          html = "<div class='errors'>#{html_tag}<ul class='errors__explanation-list'><li>#{errors.uniq.join('</li><li>')}</li></ul></div>".html_safe
        else
          html = "<div class='errors'>#{html_tag}<span class='errors__explanation'>#{errors.first}</span></div>".html_safe
        end
      end
      html
    }

    # slimテンプレート作成
    # config.generators.template_engine = :slim

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_spces: false,
        controller_specs: true,
        request_specs: false

      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    if Rails.env.production?
      config.active_job.queue_adapter = :sidekiq
    else
      config.active_job.queue_adapter = :inline
    end

  end
end
