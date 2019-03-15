require './test/test_helper'

class LoginLogoutTest < ActionDispatch::IntegrationTest
  test 'Create_login_logout' do
    get '/users/new'
    assert_response :success
    post '/users', params: {user: {login: 'test', password: 'test'}}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    get '/sess/login', params: {login: 'test', password: 'test'}
    assert_response :success
    get '/sess/logout'
    assert_response :success
  end
end
