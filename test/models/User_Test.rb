require './test/test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @ans = User.create(login: 'test', password: 'test')
  end

  test 'unique value' do
    second = @ans.dup
    assert_not second.valid?
  end
end