require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get password" do
    get :password
    assert_response :success
  end

end
