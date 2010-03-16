require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "can access home page" do
    get "/"
    assert last_response.body.include?("Login")
  end
end
