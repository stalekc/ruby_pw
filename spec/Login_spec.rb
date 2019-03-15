require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Login" do

  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://www.katalon.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_login" do
    @driver.get "http://localhost:3000/"
    @driver.find_element(:link, "Войти").click
    @driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys "admin"
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Пароль:'])[1]/following::div[1]").click
    @driver.find_element(:id, "password").click
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "admin"
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Пароль:'])[1]/following::div[1]").click
    @driver.find_element(:name, "commit").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Домой'])[1]/following::label[1]").text).should == "Admin" }
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
