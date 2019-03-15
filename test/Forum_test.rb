require './test/test_helper'

class LoginLogoutTest < ActionDispatch::IntegrationTest
  test 'Create_open' do
    get '/forums/new'
    assert_response :success
    post '/forums', params: {forum: {name: 'test'}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    get '/forums'
    assert_response :success
  end
end
