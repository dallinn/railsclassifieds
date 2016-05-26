require 'test_helper'

class ScaffoldControllerTest < ActionController::TestCase
  test "should get Post" do
    get :Post
    assert_response :success
  end

end
