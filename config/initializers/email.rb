setting_file = File.join("#{Rails.root}/config/email.yml")

if File.file?(setting_file)
  mailer_config = YAML.load(ERB.new(File.read(setting_file)).result)

  if mailer_config.is_a?(Hash) && mailer_config.has_key?(Rails.env)
    ActionMailer::Base.perform_deliveries = true
    mailer_config[Rails.env].each do |k, v|
      v.symbolize_keys! if v.respond_to?(:symbolize_keys!)
      ActionMailer::Base.send("#{k}=", v)
    end
  end
end

