APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/settings.yml")[Rails.env].symbolize_keys

Feedback::Application.configure do
  config.action_controller.default_url_options = {:host => "#{APP_CONFIG[:host]}:#{APP_CONFIG[:port]}"}
end
