Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.configure do |config|
  config.app_host = 'http://lvh.me:8080'
  config.always_include_port = true
  config.javascript_driver = :chrome
  config.server_host = "lvh.me"
  config.server_port = "8080"
end
