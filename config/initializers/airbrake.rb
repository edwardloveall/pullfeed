Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = %w(development test staging)
  config.project_key = ENV['AIRBRAKE_KEY']
  config.project_id = ENV['AIRBRAKE_PROJECT_ID']
end
