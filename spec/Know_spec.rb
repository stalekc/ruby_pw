require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Know" do

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
  
  it "test_know" do
    @driver.get "http://localhost:3000/"
    @driver.find_element(:link, "Домой").click
    @driver.find_element(:name, "commit").click
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Написано сообщений -'])[1]/following::td[1]").text).should == "0" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Зарегистрировано пользователей -'])[1]/following::td[1]").text).should == "7" }
    verify { (@driver.find_element(:xpath, "(.//*[normalize-space(text()) and normalize-space(.)='Создано форумов -'])[1]/following::td[1]").text).should == "2" }
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
