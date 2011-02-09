require 'test_helper'

class Api::V2::DetectControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
