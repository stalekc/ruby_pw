require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "NoMessageWithoutLogin" do

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
  
  it "test_no_message_without_login" do
    @driver.get "http://localhost:3000/forums/1?utf8=%E2%9C%93&str=1&commit=1"
    @driver.find_element(:link, "Домой").click
    verify { (@driver.find_element(:link, "Войти").text).should == "Войти" }
    @driver.find_element(:link, "Главный").click
    @driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Расчет окончен'])[1]/following::p[1]").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Расчет окончен'])[1]/following::p[1]").text).should == "Войдите в систему чтобы отправить сообщение" }
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
