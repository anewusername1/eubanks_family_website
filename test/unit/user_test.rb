require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def user_create_should_work_valid_parms
    assert_difference('User.count') do 
      Factory.create(:user)
    end
    
    assert_redirected_to user_path
  end
end
