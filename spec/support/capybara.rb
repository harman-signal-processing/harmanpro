Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-gpu' if Gem.win_platform?
    # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
    opts.args << '--disable-site-isolation-trials'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.javascript_driver = :headless_chrome
Capybara.asset_host = 'http://localhost:3111'
Capybara.match = :prefer_exact
Capybara.server = :webrick

#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, browser: :chrome)
#end

#Capybara.configure do |config|
#  config.default_max_wait_time = 10 # seconds
#end

